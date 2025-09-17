#!/bin/bas
git checkout -b branch2
touch file4
git add file4
git commit -m "added git add file4"
cho "changes added" >> file4
git add file4
git stash
git checkout main