#!/bin/bash#!/bin/bash
if [ "$1" == "add" ]; then
     if [ -f tasks.txt ]; then
        x=$(wc -l < tasks.txt)
    else
        x=0
    fi
    y=$((x + 1))
    echo "$y. $2" >> tasks.txt
    echo "Task added:$y. $2"
    elif [ "$1" == "list" ]; then
    cat tasks.txt
    elif [ "$1" = "del" ]; then
    task_number=$2
    if [ ! -f tasks.txt ]; then
        echo "No tasks found."
        exit 1
    fi
    # Delete the line that starts with: "number. "
    sed -i "${task_number}d" tasks.txt
    echo "Deleted task number $task_number"
    else
    echo "Usage: $0 {add|list|del} [task]"
fi

