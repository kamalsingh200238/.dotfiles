#!/bin/bash
# Claude Code status line: model + thinking level, context usage, 5h/7d rate limit usage.
input=$(cat)

eval "$(echo "$input" | jq -r '
  .context_window as $c |
  @sh "model=\(.model.display_name // "unknown")",
  @sh "effort=\(.effort.level // "")",
  @sh "used_pct=\($c.used_percentage // "")",
  # Live context is the whole current turn: fresh input, both cache halves, and output.
  @sh "used_tok=\(if $c then ($c.current_usage | (.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0) + (.output_tokens // 0)) else "" end)",
  @sh "max_tok=\($c.context_window_size // "")",
  @sh "five=\(.rate_limits.five_hour.used_percentage // "")",
  @sh "week=\(.rate_limits.seven_day.used_percentage // "")"
')"

DIM=$'\033[2m'
CYAN=$'\033[2;36m'
GREEN=$'\033[2;32m'
YELLOW=$'\033[2;33m'
RED=$'\033[2;31m'
MAGENTA=$'\033[2;35m'
RESET=$'\033[0m'

# Green under 60%, amber to 85%, red past that - same thresholds everywhere.
heat() {
  local v=${1%%.*}
  if [ "${v:-0}" -ge 85 ]; then printf '%s' "$RED"
  elif [ "${v:-0}" -ge 60 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

# Filled/empty block bar. $1 = percent, $2 = cell count.
bar() {
  awk -v p="$1" -v n="$2" 'BEGIN{
    f=int(p*n/100+0.5); if(f>n)f=n; if(f<1&&p>0)f=1;
    for(i=0;i<n;i++) printf "%s", (i<f ? "█" : "░")
  }'
}

# 32728 -> 33k, 1000000 -> 1M. Keeps the token pair short enough to sit inline.
tokens() {
  awk -v t="$1" 'BEGIN{
    if(t>=1000000){ v=t/1000000; printf (v==int(v) ? "%dM" : "%.1fM"), v }
    else if(t>=1000) printf "%dk", int(t/1000+0.5)
    else printf "%d", t
  }'
}

parts=("${CYAN}${model}${RESET}${effort:+ ${MAGENTA}${effort}${RESET}}")

if [ -n "$used_pct" ]; then
  ctx="$(bar "$used_pct" 10)"
  [ -n "$max_tok" ] && ctx="$ctx $(tokens "$used_tok")/$(tokens "$max_tok")"
  parts+=("$(heat "$used_pct")${ctx} $(printf '%.0f' "$used_pct")%${RESET}")
fi

[ -n "$five" ] && parts+=("$(heat "$five")5h $(bar "$five" 10) $(printf '%.0f' "$five")%${RESET}")
[ -n "$week" ] && parts+=("$(heat "$week")7d $(bar "$week" 10) $(printf '%.0f' "$week")%${RESET}")

sep="${DIM} │ ${RESET}"
out=""
for p in "${parts[@]}"; do
  out="${out:+$out$sep}$p"
done
printf '%s\n' "$out"
