---
description: Web research workflow with sources
---
Research the topic: $@

Workflow:
1. Prefer native provider web search if available.
2. If native web search is unavailable, use the `web_search` tool.
3. Use `web_fetch` on the most relevant URLs to verify details from primary sources.
4. Keep the answer concise and include a sources section with direct URLs.
5. Distinguish between search snippets and fetched page content.
6. For every factual claim, place a short clickable markdown citation immediately beside it using the label `[link](URL)`.
7. Do not paste raw URLs.
8. Do not add a separate sources section at the bottom unless the user explicitly asks for one.
