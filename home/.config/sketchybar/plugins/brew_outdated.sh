#!/usr/bin/env bash

# brew needs a full PATH (it shells out to git/curl by name)
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# sketchybar spawns plugins with SIGCHLD ignored, which crashes brew's Ruby
# ("undefined method 'success?' for nil" — it can't reap child statuses).
# A shell can't un-ignore an inherited SIGCHLD, so reset it via perl and exec.
COUNT="$(perl -e '$SIG{CHLD} = "DEFAULT"; exec "brew", "outdated", "--quiet"' 2>/dev/null | wc -l | tr -d ' ')"

if [ "${COUNT:-0}" -gt 0 ]; then
	sketchybar --set "$NAME" drawing=on label="$COUNT"
else
	sketchybar --set "$NAME" drawing=off
fi
