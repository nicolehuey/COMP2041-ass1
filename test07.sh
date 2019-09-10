#!/bin/dash
# test legit-merge

# error when merge when no commit files
./legit-init
./legit-merge master -m note
echo hi > a
./legit-add a
./legit-commit -m 'first'
# error when no commit msg or branch given or incorrect flag
./legit-merge
./legit-merge master
./legit-merge master -m
./legit-merge master -c
# merge when no new updates
./legit-branch b1
./legit-checkout b1
./legit-merge master -m note
echo hi > h
./legit-merge master -m note
# successful merge with no conflicts
./legit-checkout master
echo hi > b
echo world >> b
echo again >> b
./legit-add b
./legit-commit -m 'second'
./legit-checkout b1
perl -pi -e 's/hi/hello/' b
cat b
./legit-commit -a -m 'second'
./legit-checkout master
perl -pi -e 's/world/girl/' b
cat b
./legit-commit -a -m 'second'
./legit-merge b1 -m note
cat b
# merging w conflicts - error
# show files that cannot be merged
echo hi > c
echo world >> c
./legit-add c
./legit-commit -m 'third'
perl -pi -e 's/again/sup/' b
./legit-commit -a -m 'third'
./legit-checkout b1
perl -pi -e 's/hi/hello/' c
perl -pi -e 's/again/boo/' b
./legit-commit -a -m 'third'
./legit-checkout master
./legit-merge b1 -m note
