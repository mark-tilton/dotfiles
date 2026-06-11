#!/usr/bin/env bash

# Pomodoro timer shared by sketchybar and Raycast script commands.
#   pomodoro.sh start [minutes]   begin a timer (default 25)
#   pomodoro.sh stop              cancel
#   pomodoro.sh toggle            stop if running, else start 25
#   pomodoro.sh                   render into the sketchybar item (update_freq tick)

STATE="$HOME/.cache/pomodoro_end"
ITEM="pomodoro"

case "$1" in
start)
	MINS="${2:-25}"
	mkdir -p "$(dirname "$STATE")"
	echo "$(($(date +%s) + MINS * 60))" >"$STATE"
	;;
stop)
	rm -f "$STATE"
	;;
toggle)
	if [ -f "$STATE" ]; then rm -f "$STATE"; else
		mkdir -p "$(dirname "$STATE")"
		echo "$(($(date +%s) + 25 * 60))" >"$STATE"
	fi
	;;
esac

if [ -f "$STATE" ]; then
	LEFT="$(($(cat "$STATE") - $(date +%s)))"
	if [ "$LEFT" -le 0 ]; then
		rm -f "$STATE"
		osascript -e 'display notification "Time for a break" with title "Pomodoro done" sound name "Glass"'
		sketchybar --set "$ITEM" drawing=off
	else
		sketchybar --set "$ITEM" drawing=on label="$(printf '%d:%02d' $((LEFT / 60)) $((LEFT % 60)))"
	fi
else
	sketchybar --set "$ITEM" drawing=off
fi
