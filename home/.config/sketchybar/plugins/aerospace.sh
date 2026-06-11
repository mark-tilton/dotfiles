#!/usr/bin/env bash

# $1 = workspace id of this item. Highlights the focused workspace and renders
# icons for the apps on it (sketchybar-app-font via icon_map.sh).
# FOCUSED_WORKSPACE is set by the aerospace_workspace_change trigger; fall back
# to a query for other events (front_app_switched, initial load).

source "$CONFIG_DIR/plugins/icon_map.sh"

SID="$1"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

ICONS=""
while IFS= read -r app; do
	[ -z "$app" ] && continue
	__icon_map "$app"
	ICONS+="$icon_result "
done < <(aerospace list-windows --workspace "$SID" --format '%{app-name}' | sort -u)

if [ -z "$ICONS" ] && [ "$SID" != "$FOCUSED" ]; then
	sketchybar --set "$NAME" drawing=off
	exit 0
fi

if [ "$SID" = "$FOCUSED" ]; then
	sketchybar --set "$NAME" drawing=on background.drawing=on \
		icon.color=0xff1f1f28 label.color=0xff1f1f28 label="$ICONS"
else
	sketchybar --set "$NAME" drawing=on background.drawing=off \
		icon.color=0xff727169 label.color=0xff727169 label="$ICONS"
fi
