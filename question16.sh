#!/bin/bash
cd git-practice-02
git fetch --all --prune
git checkout -b branch2 origin/branch2
git checkout -b branch3 origin/branch3
git checkout branch2
git merge branch3
git add .
git commit -m "Merge branch3 into branch2 and resolve conflicts"
git branch -d branch3