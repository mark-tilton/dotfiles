#!/usr/bin/env bash

# $INFO is the new volume (0-100), provided by the volume_change event
VOL="${INFO:-0}"

case "$VOL" in
[6-9][0-9] | 100) ICON="󰕾" ;;
[3-5][0-9]) ICON="󰖀" ;;
[1-9] | [1-2][0-9]) ICON="󰕿" ;;
*) ICON="󰖁" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${VOL}%"
