#!/bin/bash

echo "Reading $1"
 
while read line
do
repo=$line
echo "###"
echo "Processing $repo"
git clone --bare git@git.designhammer.net:$repo
cd $repo.git

echo "Creating repo in Bitbucket"
curl --user USER:PASSWORD https://api.bitbucket.org/1.0/repositories/ --data name=$repo --data is_private=true --data owner=designhammer

echo "Pushing mirror to bitbucket"
git push --mirror git@bitbucket.org:designhammer/$repo.git
cd ..

echo "Removing $repo.git" 
rm -rf "$repo.git" 

echo "Waiting 5 seconds" 
echo "###" 
sleep 5;
done < $1

exit