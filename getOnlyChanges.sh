#!/bin/bash

#This is a simple script that takes two parameters... The original tag from a git repo and the new tag.
#Usage: ./getOnlyChanges.sh tag1 tag2
#
#It will give you a zip file containing all the files that were modified or added. 
#It will also echo out the names and locations of all files that have been deleted between the two tags.
#

##THESE LINES SHOULD BE CHANGED TO MATCH SERVER
#Define the location of the git repo.
projectName=whateverYouWantToNameTheProject
gitDirectory=/path/to/git/repository
deployDirectory=/path/to/folder/for/zip/files/for/deploys

#DO NOT CHANGE BELOW THIS LINE.

currentTagValue=$1
newRepoTagValue=$2

#Creating zip file name for this deploy
zipFileName=${projectName}-${currentTagValue}-to-${newRepoTagValue}.zip

#Move to git directory - When logging in remotely, this is not going to work!
cd ${gitDirectory}

git --git-dir=${gitDirectory}/.git diff --name-only -a ${currentTagValue} ${newRepoTagValue} | xargs zip ${deployDirectory}/${zipFileName}

echo "Deployed to ${deployDirectory}/${zipFileName}"

echo "Please delete the following files:"
echo $(git --git-dir=${gitDirectory}/.git diff --diff-filter=D --name-only -a ${currentTagValue} ${newRepoTagValue})
