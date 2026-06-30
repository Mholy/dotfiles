#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch — skip optional locks to avoid hanging
branch=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Line 1: model + context usage
line1=""
[ -n "$model" ] && line1="$model"
if [ -n "$used" ]; then
  printf -v used_rounded "%.0f" "$used"
  [ -n "$line1" ] && line1="$line1  ctx:${used_rounded}%" || line1="ctx:${used_rounded}%"
fi

# Line 2: git branch
line2=""
[ -n "$branch" ] && line2=" $branch"

# Output
if [ -n "$line1" ] && [ -n "$line2" ]; then
  printf "%s\n%s" "$line1" "$line2"
elif [ -n "$line1" ]; then
  printf "%s" "$line1"
elif [ -n "$line2" ]; then
  printf "%s" "$line2"
fi
