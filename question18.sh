#!/bin/bash
cd git-practice-04
git fetch --all --prune
git checkout -b ready1 origin/ready1
git checkout -b ready2 origin/ready2
git checkout -b ready3 origin/ready3
git checkout -b update1 origin/update1
git checkout -b update2 origin/update2
git checkout main
git fetch --all --prune && git checkout main && git pull --ff-only origin main && for b in $(git for-each-ref --format='%(refname:short)' refs/remotes/origin/ready*); do git merge --no-ff --no-edit "$b" || break; done
git merge ready1
git merge ready2
git merge ready3
git add .
git commit -m "ready branches changes"
git branch -d ready1
git branch -d ready2
git branch -d ready3
git add .
git commit -m "commit deleted branches changes"
git fetch --all --prune && git checkout -B main origin/main && git pull --ff-only origin main && for r in $(git for-each-ref --format='%(refname:short)' refs/remotes/origin/update*); do b=${r#origin/}; git checkout -B "$b" "$r" && git merge --no-ff --no-edit main || { echo "⚠️ Conflicts in $b — resolve, then: git add -A && git commit -m 'Merge main into $b (resolved)'; re-run to continue."; break; }; done && git checkout main
git add .
git commit -m "updated all update branches"