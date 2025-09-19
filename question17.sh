#!/bin/bash
cd git-practice-03
git fetch --all --prune
git checkout -b branch1
git merge main
git checkout -b branch2
git merge main
git checkout main
cp dir3/bar dir3/bar_copy
LC_COLLATE=en_AU.UTF-8 tree --dirsfirst
git add .
git commit -m "bar_copy added"
git checkout branch1
mv dir1/dir2/foo dir1/foo
rm -r dir1/dir2
touch newfile1
LC_COLLATE=en_AU.UTF-8 tree --dirsfirst
git add .
git commit -m "added changeds to branch 1"
git checkout branch2
mv dir1/dir2/foo dir1/dir2/foo_modified
mv dir3 dir1/dir3
rm dir1/dir3/bar
touch dir1/dir3/newfile2
LC_COLLATE=en_AU.UTF-8 tree --dirsfirst
git add .
git commit -m "added changeds to branch 2"