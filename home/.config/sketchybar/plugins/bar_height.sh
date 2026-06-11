#!/usr/bin/env bash

# The bar should fill the notch row on the built-in display (windows can't use
# it anyway), but stay slimmer on flat external screens. safeAreaInsets.top is
# the notch row height (0 on non-notched displays).
notch=$(osascript -l JavaScript -e '
ObjC.import("AppKit");
let h = 0;
const s = $.NSScreen.screens;
for (let i = 0; i < s.count; i++) {
	const t = s.objectAtIndex(i).safeAreaInsets.top;
	if (t > h) h = t;
}
h' 2>/dev/null)
notch=${notch%.*}

height=32
[ -n "$notch" ] && [ "$notch" -gt "$height" ] && height=$notch

sketchybar --bar height=$height
