#!/bin/bash

PROJECT_PATH=$(find $HOME/Projects -mindepth 2 -maxdepth 2 -type d | fzf)

# check if project path was selected
if [ -z $PROJECT_PATH ]; then
    PROJECT_PATH=$HOME
fi


IFS='/' read -r -a array <<< "$PROJECT_PATH"


# Get the length of the array
length=${#array[@]}

# Extract the last two elements
PROJECT_NAME="${array[length-2]}-${array[length-1]}"
tmux has-session -t $PROJECT_NAME 2>/dev/null
if [ $? -eq 0 ]; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $PROJECT_NAME
    else
        tmux attach-session -t $PROJECT_NAME
    fi
else
    if [ -n "$TMUX" ]; then
        tmux detach-client -s $PROJECT_NAME
        tmux new-session -Ad -s $PROJECT_NAME -c $PROJECT_PATH
        tmux switch-client -t $PROJECT_NAME
    else
        tmux new-session -Ad -s $PROJECT_NAME -c $PROJECT_PATH
        tmux attach-session -t $PROJECT_NAME
    fi
fi



