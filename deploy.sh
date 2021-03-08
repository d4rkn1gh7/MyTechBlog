#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mPushing source code to MyBlog...\033[0m\n"

echo "[+]Deleting public directory"
rm -rf public

echo "[+]Generating public"

hugo -v

echo "[+]Copying public to Blog site"
cp -rfv public/* ~/d4rkn1gh7.github.io

echo "[*]removed public"
rm -rf public

git add .

#echo "Enter commit message"
#read msg
# Build the project.
git commit -m "$1" # if using a theme, replace with `hugo -t <YOURTHEME>`

git push origin main

# Go To Public folder
cd ~/d4rkn1gh7.github.io 

printf "\033[0;32mUpdating the website...\033[0m\n"
# Add changes to git.
git add .

# Commit changes.
git commit -m "$1"

# Push source and build repos.
git push origin main
