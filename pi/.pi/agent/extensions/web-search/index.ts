import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "typebox";

type SearchResult = {
  title: string;
  url: string;
  snippet?: string;
  displayUrl?: string;
  source: string;
  rank: number;
};

type SearchResponse = {
  query: string;
  backend: string;
  results: SearchResult[];
  truncated: boolean;
};

type ExaMcpRpcResponse = {
  result?: {
    content?: Array<{ type?: string; text?: string }>;
    isError?: boolean;
  };
  error?: {
    code?: number;
    message?: string;
  };
};

type ParsedResult = {
  title: string;
  url: string;
  content: string;
};

const DEFAULT_TIMEOUT_SECONDS = 20;
const MAX_TIMEOUT_SECONDS = 60;
const DEFAULT_RESULT_LIMIT = 5;
const MAX_RESULT_LIMIT = 10;
const MAX_OUTPUT_CHARS = 20_000;
const EXA_MCP_URL = "https://mcp.exa.ai/mcp";

function truncateContent(content: string): { content: string; truncated: boolean } {
  if (content.length <= MAX_OUTPUT_CHARS) {
    return { content, truncated: false };
  }

  return { content: content.slice(0, MAX_OUTPUT_CHARS), truncated: true };
}

function normalizeWhitespace(input: string): string {
  return input.replaceAll(/\s+/g, " ").trim();
}

function safeUrl(rawUrl: string): string | null {
  if (!rawUrl) return null;
  try {
    return new URL(rawUrl).toString();
  } catch {
    return null;
  }
}

function buildHeaders(): Record<string, string> {
  return {
    "Content-Type": "application/json",
    Accept: "application/json, text/event-stream",
  };
}

function requestSignal(signal?: AbortSignal): AbortSignal {
  const timeout = AbortSignal.timeout(MAX_TIMEOUT_SECONDS * 1000);
  return signal ? AbortSignal.any([signal, timeout]) : timeout;
}

async function callExaMcp(
  toolName: string,
  args: Record<string, unknown>,
  signal?: AbortSignal,
): Promise<string> {
  const response = await fetch(EXA_MCP_URL, {
    method: "POST",
    headers: buildHeaders(),
    body: JSON.stringify({
      jsonrpc: "2.0",
      id: 1,
      method: "tools/call",
      params: {
        name: toolName,
        arguments: args,
      },
    }),
    signal: requestSignal(signal),
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Exa MCP error ${response.status}: ${errorText.slice(0, 300)}`);
  }

  const body = await response.text();
  const dataLines = body.split("\n").filter((line) => line.startsWith("data:"));

  let parsed: ExaMcpRpcResponse | null = null;
  for (const line of dataLines) {
    const payload = line.slice(5).trim();
    if (!payload) continue;
    try {
      const candidate = JSON.parse(payload) as ExaMcpRpcResponse;
      if (candidate?.result || candidate?.error) {
        parsed = candidate;
        break;
      }
    } catch {
      // Ignore invalid SSE fragments.
    }
  }

  if (!parsed) {
    try {
      const candidate = JSON.parse(body) as ExaMcpRpcResponse;
      if (candidate?.result || candidate?.error) {
        parsed = candidate;
      }
    } catch {
      // Ignore non-JSON bodies.
    }
  }

  if (!parsed) {
    throw new Error("Exa MCP returned an empty response");
  }

  if (parsed.error) {
    const code = typeof parsed.error.code === "number" ? ` ${parsed.error.code}` : "";
    const message = parsed.error.message || "Unknown error";
    throw new Error(`Exa MCP error${code}: ${message}`);
  }

  if (parsed.result?.isError) {
    const message = parsed.result.content
      ?.find((item) => item.type === "text" && typeof item.text === "string")
      ?.text?.trim();
    throw new Error(message || "Exa MCP returned an error");
  }

  const text = parsed.result?.content
    ?.find((item) => item.type === "text" && typeof item.text === "string" && item.text.trim().length > 0)
    ?.text;

  if (!text) {
    throw new Error("Exa MCP returned empty content");
  }

  return text;
}

function buildMcpQuery(query: string, domainFilter?: string[], recencyFilter?: string): string {
  const parts = [query];

  if (domainFilter?.length) {
    for (const domain of domainFilter) {
      const trimmed = domain.trim();
      if (!trimmed) continue;
      parts.push(trimmed.startsWith("-") ? `-site:${trimmed.slice(1)}` : `site:${trimmed}`);
    }
  }

  if (recencyFilter) {
    const normalized = recencyFilter.trim().toLowerCase();
    if (normalized === "day") parts.push("past 24 hours");
    if (normalized === "week") parts.push("past week");
    if (normalized === "month") parts.push("past month");
    if (normalized === "year") parts.push("past year");
  }

  return parts.join(" ").trim();
}

function parseMcpResults(text: string): ParsedResult[] | null {
  const blocks = text.split(/(?=^Title: )/m).filter((block) => block.trim().length > 0);
  const parsed = blocks.map((block) => {
    const title = block.match(/^Title: (.+)/m)?.[1]?.trim() ?? "";
    const url = block.match(/^URL: (.+)/m)?.[1]?.trim() ?? "";
    const textStart = block.indexOf("\nText: ");
    const highlightsMatch = block.match(/\nHighlights:\s*\n/m);
    let content = "";

    if (textStart >= 0) {
      content = block.slice(textStart + 7).trim();
    } else if (highlightsMatch?.index != null) {
      content = block.slice(highlightsMatch.index + highlightsMatch[0].length).trim();
    }

    content = content.replace(/\n---\s*$/, "").trim();
    return { title, url, content };
  }).filter((result) => result.url.length > 0);

  return parsed.length > 0 ? parsed : null;
}

function buildAnswerFromResults(results: ParsedResult[]): string {
  const parts: string[] = [];

  for (let i = 0; i < results.length; i += 1) {
    const result = results[i];
    const snippet = normalizeWhitespace(result.content).slice(0, 500);
    if (!snippet) continue;
    const sourceTitle = result.title || `Source ${i + 1}`;
    parts.push(`${snippet}\nSource: ${sourceTitle} (${result.url})`);
  }

  return parts.join("\n\n");
}

function renderResults(query: string, response: SearchResponse): string {
  const lines: string[] = [
    `Search results for: ${query}`,
    `Backend: ${response.backend}`,
    "",
  ];

  if (!response.results.length) {
    lines.push("No results found.");
    return lines.join("\n");
  }

  for (const result of response.results) {
    lines.push(`${result.rank}. [${result.title}](${result.url})`);
    if (result.displayUrl) {
      lines.push(`   Source: ${result.displayUrl}`);
    }
    if (result.snippet) {
      lines.push(`   ${result.snippet}`);
    }
    lines.push("");
  }

  return lines.join("\n").trim();
}

async function searchWithExaMcp(
  query: string,
  limit: number,
  signal?: AbortSignal,
): Promise<SearchResponse> {
  const enrichedQuery = buildMcpQuery(query);
  const text = await callExaMcp(
    "web_search_exa",
    {
      query: enrichedQuery,
      numResults: limit,
      livecrawl: "fallback",
      type: "auto",
      contextMaxCharacters: 3000,
    },
    signal,
  );

  const parsedResults = parseMcpResults(text);
  if (!parsedResults) {
    throw new Error("Exa MCP returned no parseable results");
  }

  return {
    query,
    backend: "exa-mcp",
    results: parsedResults.map((result, index) => ({
      title: result.title || `Source ${index + 1}`,
      url: safeUrl(result.url) || result.url,
      snippet: normalizeWhitespace(result.content).slice(0, 300),
      displayUrl: safeUrl(result.url) || result.url,
      source: "exa-mcp",
      rank: index + 1,
    })),
    truncated: false,
  };
}

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_search",
    label: "Web Search",
    description: "Search the web via Exa MCP and return ranked results with snippets.",
    parameters: Type.Object({
      query: Type.String({ description: "Search query" }),
      limit: Type.Optional(
        Type.Integer({
          minimum: 1,
          maximum: MAX_RESULT_LIMIT,
          description: "Maximum number of results to return",
        }),
      ),
      timeout: Type.Optional(
        Type.Integer({
          minimum: 1,
          maximum: MAX_TIMEOUT_SECONDS,
          description: "Optional timeout in seconds",
        }),
      ),
    }),
    async execute(_toolCallId, params, signal) {
      const query = normalizeWhitespace(params.query);
      if (!query) {
        throw new Error("Query must not be empty");
      }

      const limit = Math.min(params.limit ?? DEFAULT_RESULT_LIMIT, MAX_RESULT_LIMIT);
      const timeoutMs = Math.min((params.timeout ?? DEFAULT_TIMEOUT_SECONDS) * 1000, MAX_TIMEOUT_SECONDS * 1000);
      const timeoutSignal = AbortSignal.timeout(timeoutMs);
      const effectiveSignal = signal ? AbortSignal.any([signal, timeoutSignal]) : timeoutSignal;

      const page = await searchWithExaMcp(query, limit, effectiveSignal);
      const results = page.results.slice(0, limit);
      const response: SearchResponse = {
        ...page,
        results,
      };
      const { content, truncated } = truncateContent(renderResults(query, response));

      const answer = buildAnswerFromResults(results.map((result) => ({
        title: result.title,
        url: result.url,
        content: result.snippet ?? "",
      })));

      return {
        content: [{ type: "text", text: content }],
        details: {
          ...response,
          answer,
          truncated,
        },
      };
    },
  });
}
