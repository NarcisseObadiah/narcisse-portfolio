#!/bin/bash

echo "Removing large files and setting up Git LFS..."

# Remove large files using BFG
java -jar bfg-1.13.0.jar --strip-blobs-bigger-than 100M

# Clean up the repository
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Install and track large files with Git LFS
git lfs install
git lfs track "node_modules/node/bin/node"
git lfs track ".next/cache/webpack/client-production/0.pack"
git lfs track ".next/cache/webpack/server-production/0.pack"
git lfs track "node_modules/@next/swc-linux-x64-gnu/next-swc.linux-x64-gnu.node"
git lfs track "node_modules/@next/swc-linux-x64-musl/next-swc.linux-x64-musl.node"

# Add .gitattributes and commit
git add .gitattributes
git add node_modules/node/bin/node
git add .next/cache/webpack/client-production/0.pack
git add .next/cache/webpack/server-production/0.pack
git add node_modules/@next/swc-linux-x64-gnu/next-swc.linux-x64-gnu.node
git add node_modules/@next/swc-linux-x64-musl/next-swc.linux-x64-musl.node
git commit -m "Track large files with Git LFS"

# Push changes
git push --force

echo "Cleanup and LFS setup complete."
