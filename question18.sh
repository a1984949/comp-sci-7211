#!/bin/bash
set -euo pipefail

cd git-practice-04

# 1) Identify all branches
git fetch --all --prune
echo "== All branches (local + remote) =="
git branch -a | tee branches_all.txt

# Ensure local 'main' is up to date
git checkout -B main origin/main
git pull --ff-only origin main || true

# Create/refresh local tracking branches for ready* and update* (if any exist)
for r in $(git branch -r --list 'origin/ready*'  | sed 's#origin/##');  do git checkout -B "$r" "origin/$r"; done
for r in $(git branch -r --list 'origin/update*' | sed 's#origin/##');  do git checkout -B "$r" "origin/$r"; done

# 2) Merge ALL ready* branches into main
git checkout main
for b in $(git branch --list 'ready*'); do
  echo "== Merging $b into main =="
  if git merge --no-ff --no-edit "$b"; then
    echo "Merged $b."
  else
    echo "Conflicts while merging $b. Saving conflicted files and exiting."
    git diff --name-only --diff-filter=U | tee "conflicts_${b}.txt"
    echo "Resolve conflicts, then:"
    echo "  git add -A && git commit -m 'Merge $b into main (resolved)'"
    echo "Re-run this script to continue."
    exit 1
  fi
done

# 3) Delete those ready* branches (local)
for b in $(git branch --list 'ready*'); do
  git branch -d "$b" || git branch -D "$b"
done

# 4) Update ALL update* branches with latest main
for b in $(git branch --list 'update*'); do
  echo "== Updating $b with main =="
  git checkout "$b"
  if git merge --no-ff --no-edit main; then
    echo "Updated $b with main."
  else
    echo "⚠️ Conflicts while updating $b. Saving conflicted files and exiting."
    git diff --name-only --diff-filter=U | tee "conflicts_update_${b}.txt"
    echo "Resolve conflicts, then:"
    echo "  git add -A && git commit -m 'Merge main into $b (resolved)'"
    echo "Re-run this script to continue."
    exit 1
  fi
done

# Back to main at the end
git checkout main
echo "Done."
