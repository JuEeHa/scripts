#!/bin/sh
git add --all .
git commit -m "$*"
test ! -n "$branch" && branch=master
git push origin $branch
