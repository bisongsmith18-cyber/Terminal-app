#!/bin/bash

FILE="tasks.txt"

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

[[ ! -f "$FILE" ]] && touch "$FILE"

if [[ -z "$1" ]]; then
    echo -e "${YELLOW}Usage:${RESET} ./todo.sh {add|list|del|clear} [task/number]"
    exit 1
fi

case "$1" in

add)
    [[ -z "$2" ]] && echo -e "${RED}Error:${RESET} No task provided." && exit 1

    TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
    echo "[$TIMESTAMP] $2" >> "$FILE"

    echo -e "${GREEN} Task added:${RESET} $2"
    echo -e "${CYAN} Time:${RESET} $TIMESTAMP"
    ;;

list)
    if [[ ! -s "$FILE" ]]; then
        echo -e "${CYAN}No tasks found.${RESET}"
    else
        echo -e "${CYAN}Your Tasks:${RESET}"
        nl -w2 -s'. ' "$FILE"
    fi
    ;;

del)
    [[ -z "$2" ]] && echo -e "${RED}Error:${RESET} Provide a task number to delete." && exit 1

    TOTAL=$(wc -l < "$FILE")

    if (( $2 < 1 || $2 > TOTAL )); then
        echo -e "${RED} Error:${RESET} Task number does not exist."
        exit 1
    fi

    sed -i "${2}d" "$FILE"
    echo -e "${GREEN} Task $2 deleted.${RESET}"
    ;;

clear)
    if [[ ! -s "$FILE" ]]; then
        echo -e "${CYAN} Task list already empty.${RESET}"
    else
        > "$FILE"
        echo -e "${RED}All tasks cleared!${RESET}"
    fi
    ;;

*)
    echo -e "${RED} Invalid command.${RESET}"
    echo -e "${YELLOW}Usage:${RESET} ./todo.sh {add|list|del|clear}"
    ;;

esac