#!/bin/bash
TODO_FILE="tasks.txt" # Stores the tasks in a hidden file in your home directory
# Ensure the TODO file exists
initialize() {
  if [ ! -f "$TODO_FILE" ]; then
    touch "$TODO_FILE"
  fi
}
add_task() {
  if [ -z "$1" ]; then
    echo "Usage: add <task description>"
    return 1
  fi
  echo "$(date) - $1" >> "$TODO_FILE"
  echo "Task added: $1"
}
view_tasks() {
  if [ ! -s "$TODO_FILE" ]; then
    echo "No pending tasks."
  else
    echo "Your To-Do List:"
    cat -n "$TODO_FILE" # Displays tasks with line numbers
  fi
}
remove_task() {
  if [ -z "$1" ]; then
    echo "Usage: remove <task_number>"
    return 1
  fi
  if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Task number must be an integer."
    return 1
  fi
  # Use sed to delete the specified line
  sed -i "${1}d" "tasks.txt"
  echo "Task $1 removed."
}
# Main script logic
initialize
case "$1" in
  add)
    shift
    add_task "$@"
    ;;
  list)
    view_tasks
    ;;
  remove)
    shift
    remove_task "$@"
    ;;
  *)
    echo "Usage: todo.sh [add <task>] | [list] | [remove <task_number>]"
    ;;
esac