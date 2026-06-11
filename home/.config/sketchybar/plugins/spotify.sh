#!/usr/bin/env bash

if pgrep -xq Spotify; then
	STATE="$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)"
	if [ "$STATE" = "playing" ]; then
		TRACK="$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)"
		ARTIST="$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)"
		sketchybar --set "$NAME" drawing=on label="$TRACK · $ARTIST"
		exit 0
	fi
fi

sketchybar --set "$NAME" drawing=off
