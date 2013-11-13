#!/bin/sh
test -n "$(git ls-files --deleted)" && git rm $(git ls-files --deleted)
git add .
git commit -m "$*"
test ! -n "$branch" && branch=master
git push origin $branch
