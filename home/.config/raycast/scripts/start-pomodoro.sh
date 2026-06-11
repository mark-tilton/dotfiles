#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Pomodoro
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🍅
# @raycast.packageName Pomodoro
# @raycast.argument1 { "type": "text", "placeholder": "minutes (default 25)", "optional": true }

"$HOME/.config/sketchybar/plugins/pomodoro.sh" start "${1:-25}"
echo "Pomodoro started: ${1:-25} minutes"
