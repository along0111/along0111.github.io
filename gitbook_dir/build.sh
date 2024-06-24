#!/bin/bash
rm -rf _book
gitbook build
cp -rf _book/* ../
git add -A 
git commit -m "change"
git push
cd ../
gitbook serve
