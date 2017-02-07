#!/usr/bin/env bash

# exit with nonzero exit code if anything fails
set -e

# Local variables
OUT=".gh-pages"
ID=$(git rev-parse --short HEAD)
DATE=$(date)

# clear and re-create the out directory
rm -rf $OUT || exit 0;

# clone repo directory
git clone "https://${GH_TOKEN}@${GH_REF}" $OUT
cd $OUT
git checkout gh-pages || git checkout --orphan gh-pages
git rm -rf .*
cd ..

# Copy all prebuild files
cp README.* $OUT
cp -R * $OUT
cp -f circle.yml $OUT

# go to the out directory and create a *new* Git repo
cd $OUT
git init

# inside this git repo we'll pretend to be a new user
git config user.name "Circle CI"
git config user.email "coldnew.tw@gmail.com"

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add .
git commit -m "Deploy commit $ID to GitHub Pages: $DATE"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
