import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import TurndownService from "turndown";
import * as cheerio from "cheerio";
import { Type } from "typebox";

type FetchFormat = "text" | "markdown" | "html";

type FetchedPage = {
  title?: string;
  content: string;
  finalUrl: string;
  contentType: string;
  mime: string;
  truncated: boolean;
};

const DEFAULT_TIMEOUT_SECONDS = 30;
const MAX_TIMEOUT_SECONDS = 120;
const MAX_RESPONSE_BYTES = 5 * 1024 * 1024;
const MAX_OUTPUT_CHARS = 24_000;
const DEFAULT_USER_AGENT =
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36";
const FALLBACK_USER_AGENT = "opencode";
const JINA_READER_PREFIX = "https://r.jina.ai/http://";

const turndown = new TurndownService({
  headingStyle: "atx",
  bulletListMarker: "-",
  codeBlockStyle: "fenced",
  emDelimiter: "*",
  hr: "---",
});

type NormalizedHtml = {
  title?: string;
  bodyHtml: string;
  text: string;
};

function validateUrl(url: string): void {
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    throw new Error("URL must start with http:// or https://");
  }
}

function buildAcceptHeader(format: FetchFormat): string {
  switch (format) {
    case "markdown":
      return "text/markdown;q=1.0, text/x-markdown;q=0.9, text/plain;q=0.8, text/html;q=0.7, */*;q=0.1";
    case "text":
      return "text/plain;q=1.0, text/markdown;q=0.9, text/html;q=0.8, */*;q=0.1";
    case "html":
      return "text/html;q=1.0, application/xhtml+xml;q=0.9, text/plain;q=0.8, text/markdown;q=0.7, */*;q=0.1";
    default:
      return "*/*";
  }
}

function sanitizeHtml(html: string): NormalizedHtml {
  const $ = cheerio.load(html);
  $("script, style, noscript, iframe, object, embed, svg, canvas, meta, link, header, footer, nav, aside, form").remove();

  const title = $("title").first().text().trim() || undefined;
  const body = $("body");
  const bodyHtml = body.html() ?? $.root().html() ?? html;
  const text = (body.text() || $.root().text())
    .replaceAll(/\s+/g, " ")
    .trim();

  return { title, bodyHtml, text };
}

function htmlToMarkdown(html: string): string {
  return turndown
    .turndown(html)
    .replaceAll(/\r/g, "")
    .replaceAll(/\n{3,}/g, "\n\n")
    .replaceAll(/[ \t]{2,}/g, " ")
    .trim();
}

function pickReadableContent(html: string): { html: string; text: string } {
  const $ = cheerio.load(html);
  const selectors = [
    "article",
    "main",
    "[role='main']",
    "#content",
    ".content",
    ".post-content",
    ".article-content",
    ".entry-content",
  ];

  for (const selector of selectors) {
    const candidate = $(selector).first();
    if (!candidate.length) continue;
    const candidateText = candidate.text().replaceAll(/\s+/g, " ").trim();
    const candidateHtml = candidate.html()?.trim();
    if (candidateHtml && candidateText.length > 200) {
      return { html: candidateHtml, text: candidateText };
    }
  }

  const body = $("body");
  const bodyHtml = body.html() ?? $.root().html() ?? html;
  const bodyText = (body.text() || $.root().text()).replaceAll(/\s+/g, " ").trim();
  return { html: bodyHtml, text: bodyText };
}

function makeHeaders(format: FetchFormat, userAgent: string): Record<string, string> {
  return {
    "User-Agent": userAgent,
    Accept: buildAcceptHeader(format),
    "Accept-Language": "en-US,en;q=0.9",
    "Cache-Control": "no-cache",
    Pragma: "no-cache",
  };
}

function isTextLikeMime(mime: string): boolean {
  return (
    mime.startsWith("text/") ||
    mime === "application/json" ||
    mime === "application/xml" ||
    mime === "text/xml" ||
    mime.endsWith("+json") ||
    mime.endsWith("+xml")
  );
}

function isBlockedHtml(html: string): boolean {
  const lowered = html.toLowerCase();
  return (
    lowered.includes("captcha") ||
    lowered.includes("cloudflare") ||
    lowered.includes("just a moment") ||
    lowered.includes("verify you are human") ||
    lowered.includes("access denied") ||
    lowered.includes("too many requests") ||
    lowered.includes("enable javascript")
  );
}

function looksLikeJsAppShell(html: string): boolean {
  const lowered = html.toLowerCase();
  const stripped = lowered.replaceAll(/<script[\s\S]*?<\/script>/g, "");
  const visibleText = stripped.replaceAll(/<[^>]+>/g, " ").replaceAll(/\s+/g, " ").trim();
  const scriptCount = (lowered.match(/<script\b/g) || []).length;

  return (
    lowered.includes("id=\"root\"") ||
    lowered.includes("id=\"app\"") ||
    lowered.includes("__next_data__") ||
    lowered.includes("window.__initial_state__") ||
    visibleText.length < 400 ||
    (visibleText.length < 1200 && scriptCount > 3)
  );
}

function prettyJson(input: string): string {
  try {
    return JSON.stringify(JSON.parse(input), null, 2);
  } catch {
    return input;
  }
}

function buildReaderUrl(url: string): string {
  return `${JINA_READER_PREFIX}${encodeURI(url)}`;
}

function truncateContent(content: string): { content: string; truncated: boolean } {
  if (content.length <= MAX_OUTPUT_CHARS) {
    return { content, truncated: false };
  }

  return { content: content.slice(0, MAX_OUTPUT_CHARS), truncated: true };
}

async function fetchWithTimeout(
  url: string,
  format: FetchFormat,
  timeoutSeconds: number,
  userAgent: string,
): Promise<Response> {
  const controller = new AbortController();
  const timeoutMs = Math.min(timeoutSeconds * 1000, MAX_TIMEOUT_SECONDS * 1000);
  const timeout = setTimeout(() => controller.abort(new Error("Request timed out")), timeoutMs);

  try {
    return await fetch(url, {
      signal: controller.signal,
      headers: makeHeaders(format, userAgent),
      redirect: "follow",
    });
  } finally {
    clearTimeout(timeout);
  }
}

async function fetchViaReader(url: string, timeoutSeconds: number): Promise<FetchedPage> {
  const response = await fetchWithTimeout(buildReaderUrl(url), "markdown", timeoutSeconds, DEFAULT_USER_AGENT);

  if (!response.ok) {
    throw new Error(`Reader request failed: ${response.status} ${response.statusText}`);
  }

  const contentType = response.headers.get("content-type") || "text/markdown";
  const mime = contentType.split(";")[0]?.trim().toLowerCase() || "text/markdown";
  const text = new TextDecoder().decode(await response.arrayBuffer());
  const { content, truncated } = truncateContent(text);

  return {
    title: `${url} (reader)`,
    content,
    finalUrl: response.url,
    contentType,
    mime,
    truncated,
  };
}

async function fetchPage(url: string, format: FetchFormat, timeoutSeconds: number): Promise<FetchedPage> {
  const firstResponse = await fetchWithTimeout(url, format, timeoutSeconds, DEFAULT_USER_AGENT);

  const needsRetry =
    firstResponse.status === 403 &&
    firstResponse.headers.get("cf-mitigated") === "challenge";

  const response = needsRetry
    ? await fetchWithTimeout(url, format, timeoutSeconds, FALLBACK_USER_AGENT)
    : firstResponse;

  if (!response.ok) {
    if (response.status === 429 || response.status === 403) {
      return fetchViaReader(url, timeoutSeconds);
    }

    if (format !== "html") {
      return fetchViaReader(url, timeoutSeconds);
    }

    throw new Error(`Fetch request failed: ${response.status} ${response.statusText}`);
  }

  const contentLength = response.headers.get("content-length");
  if (contentLength && Number.parseInt(contentLength, 10) > MAX_RESPONSE_BYTES) {
    if (format !== "html") {
      return fetchViaReader(url, timeoutSeconds);
    }

    throw new Error("Response too large (exceeds 5MB limit)");
  }

  const arrayBuffer = await response.arrayBuffer();
  if (arrayBuffer.byteLength > MAX_RESPONSE_BYTES) {
    if (format !== "html") {
      return fetchViaReader(url, timeoutSeconds);
    }

    throw new Error("Response too large (exceeds 5MB limit)");
  }

  const contentType = response.headers.get("content-type") || "";
  const mime = contentType.split(";")[0]?.trim().toLowerCase() || "";
  const title = `${url} (${contentType})`;
  const rawContent = new TextDecoder().decode(arrayBuffer);

  if (format === "html") {
    const { content, truncated } = truncateContent(rawContent);
    return {
      title,
      content,
      finalUrl: response.url,
      contentType,
      mime,
      truncated,
    };
  }

  if (!contentType || contentType.includes("text/html") || contentType.includes("application/xhtml+xml")) {
    if (isBlockedHtml(rawContent) || looksLikeJsAppShell(rawContent)) {
      return fetchViaReader(url, timeoutSeconds);
    }

    const normalized = sanitizeHtml(rawContent);
    const readable = pickReadableContent(normalized.bodyHtml);
    const extracted = format === "markdown"
      ? htmlToMarkdown(readable.html)
      : readable.text;
    const { content, truncated } = truncateContent(extracted);

    return {
      title: normalized.title ?? title,
      content,
      finalUrl: response.url,
      contentType,
      mime,
      truncated,
    };
  }

  if (mime === "application/json" || mime.endsWith("+json")) {
    const { content, truncated } = truncateContent(prettyJson(rawContent));
    return {
      title,
      content,
      finalUrl: response.url,
      contentType,
      mime,
      truncated,
    };
  }

  if (mime === "application/xml" || mime === "text/xml" || mime.endsWith("+xml")) {
    const { content, truncated } = truncateContent(rawContent);
    return {
      title,
      content,
      finalUrl: response.url,
      contentType,
      mime,
      truncated,
    };
  }

  if (isTextLikeMime(mime)) {
    const { content, truncated } = truncateContent(rawContent);
    return {
      title,
      content,
      finalUrl: response.url,
      contentType,
      mime,
      truncated,
    };
  }

  throw new Error(`Unsupported content type: ${mime || contentType || "unknown"}`);
}

function formatFetchResult(page: FetchedPage, originalUrl: string): string {
  const lines = [`Fetched: ${originalUrl}`];

  if (page.finalUrl !== originalUrl) {
    lines.push(`Final URL: ${page.finalUrl}`);
  }

  if (page.title) {
    lines.push(`Title: ${page.title}`);
  }

  if (page.contentType) {
    lines.push(`Content-Type: ${page.contentType}`);
  }

  if (page.truncated) {
    lines.push("Truncated: yes");
  }

  lines.push("", page.content);
  return lines.join("\n");
}

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_fetch",
    label: "Web Fetch",
    description: "Fetch a URL over HTTP and extract readable content from normal, blocked, or JS-heavy pages.",
    parameters: Type.Object({
      url: Type.String({ format: "uri", description: "Absolute URL to fetch" }),
      format: Type.Optional(
        Type.Union([
          Type.Literal("text"),
          Type.Literal("markdown"),
          Type.Literal("html"),
        ]),
      ),
      timeout: Type.Optional(
        Type.Integer({
          minimum: 1,
          maximum: MAX_TIMEOUT_SECONDS,
          description: "Optional timeout in seconds",
        }),
      ),
    }),
    async execute(_toolCallId, params, _signal, _onUpdate, _ctx) {
      validateUrl(params.url);

      const format = (params.format ?? "markdown") as FetchFormat;
      const timeout = params.timeout ?? DEFAULT_TIMEOUT_SECONDS;
      const page = await fetchPage(params.url, format, timeout);

      return {
        content: [{ type: "text", text: formatFetchResult(page, params.url) }],
        details: page,
      };
    },
  });
}
