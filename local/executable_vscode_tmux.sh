#!/bin/bash
folder_name=$(basename $1)
tmux new-session -A -s vscode:$folder_name