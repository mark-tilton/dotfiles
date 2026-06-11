#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Pomodoro
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🍅
# @raycast.packageName Pomodoro

"$HOME/.config/sketchybar/plugins/pomodoro.sh" stop
echo "Pomodoro stopped"
