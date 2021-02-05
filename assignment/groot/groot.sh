#! /bin/bash

PSEUDONYM='groot'
<<<<<<< HEAD
LOCAL_DIRECTORY='/Users/doreenhiiyiijiehii/Desktop/Winter2021/PSYCH205B'

# clone the class git repo
git -C $LOCAL_DIRECTORY clone git@github.com:doreenhii/cogs-205b.git 

# makes new branch 
git -C $LOCAL_DIRECTORY/cogs-205b checkout -b upload_assignment

# makes a new directory in git repo
mkdir $LOCAL_DIRECTORY/cogs-205b/assignment/$PSEUDONYM 

# makes a copy of this file in the new directory 
cp $0 $LOCAL_DIRECTORY/cogs-205b/assignment/$PSEUDONYM

# push 
git -C $LOCAL_DIRECTORY/cogs-205b add .
git -C $LOCAL_DIRECTORY/cogs-205b commit -a -m "Adding groot.sh"
=======

# clone the class git repo
git -C $(PWD) clone git@github.com:doreenhii/cogs-205b.git 

# makes new branch 
git -C $(PWD)/cogs-205b checkout -b upload_assignment

# makes a new directory in git repo
mkdir $(PWD)/cogs-205b/assignment/$PSEUDONYM 

# makes a copy of this file in the new directory 
cp $0 $(PWD)/cogs-205b/assignment/$PSEUDONYM

# push 
git -C $(PWD)/cogs-205b add .
git -C $(PWD)/cogs-205b commit -a -m "Adding groot.sh"
>>>>>>> upstream/main
git push --set-upstream origin upload_assignment

