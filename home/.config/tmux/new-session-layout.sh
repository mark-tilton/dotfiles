#!/bin/sh
session="$1"

count=$(tmux list-windows -t "$session" | wc -l | tr -d ' ')
[ "$count" -gt 1 ] && exit 0

first=$(tmux list-windows -t "$session" -F '#{window_index}' | head -n1)
session_path=$(tmux display-message -p -t "$session:$first" '#{pane_current_path}')
git -C "$session_path" rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

tmux rename-window -t "$session:$first" nvim
tmux send-keys     -t "$session:$first" 'nvim' C-m

tmux new-window   -t "$session:" -n term
tmux split-window -h -t "$session:term"

right=$(tmux list-panes -t "$session:term" -F '#{pane_index}' | tail -n1)
left=$(tmux list-panes  -t "$session:term" -F '#{pane_index}' | head -n1)

tmux send-keys   -t "$session:term.$right" 'claude' C-m
tmux select-pane -t "$session:term.$left"

tmux select-window -t "$session:nvim"
