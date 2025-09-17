#!/bin/bash
git checkout branch2
git stash pop
git add .
git commit -m "Restore and commit previously stashed changes"