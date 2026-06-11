#!/usr/bin/env bash

CORES="$(sysctl -n hw.ncpu)"
PCT="$(ps -A -o %cpu | awk -v c="$CORES" '{s+=$1} END {printf "%.0f", s/c}')"

# cpu_text has a fixed label.width, so no padding tricks needed here
sketchybar --set cpu_text label="${PCT}%" --push cpu "$(awk -v p="$PCT" 'BEGIN{printf "%.2f", p/100}')"
