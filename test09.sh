#!/bin/dash
# test all subsets
./legit-init
echo hi > a
echo 2 > b
echo 3 > c
echo 4 > d
echo 4a >> d
./legit-add a b c
./legit-commit -m '1'
echo hello > a
./legit-commit -a -m '2'
./legit-add d
./legit-commit -m '3'
./legit-show 1:d
./legit-show 2:d
./legit-branch
./legit-checkout b1
# rm a in b1
./legit-rm a
./legit-show :a
./legit-status
# check if a exist in master
./legit-checkout master
./legit-show :a
./legit-status
# error creating existing branch
./legit-branch b1
./legit-checkout b1
cat b
echo hi > b
./legit-add b
./legit-commit -m '4'
./legit-show :b
echo sup > b
./legit-rm --force --cached b
# check merge success
./legit-checkout master
./legit-merge b1 -m merge-message
./legit-show :b
./legit-rm --cached b
perl -pi -e 's/4a/5/' d
cat d
./legit-checkout b1
echo 4 > d
echo 6 >> d
./legit-add d
./legit-commit -m 'change'
# merge conflict
./legit-checkout master
./legit-merge b1 -m merge-message
# try with diff branch
./legit-branch b2
./legit-checkout b2
echo sup > d
./legit-add d
./legit-commit -m 'change in b2'
./legit-checkout master
./legit-merge b2 -m merge-message
./legit-log
./legit-status
# nothing to merge, already up to date
./legit-branch b3
./legit-checkout b3
echo hi > j
./legit-checkout master
./legit-merge b3 -m merge-message
