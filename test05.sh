#!/bin/dash
# test legit-status

./legit-init
# print error when no commits in repo yet
./legit-status
echo hi > a
./legit-add a
./legit-status
# check status of a being same as repo
./legit-commit -m 'first'
./legit-status
# check files status are shown in sorted order
echo bye > b
./legit-add b
./legit-commit -m 'second'
./legit-status
# still works when given extra arguments
./legit-status a
./legit-status -c
# check for files not yet committed
echo hi > c
./legit-add c
./legit-status
# untracked for files not added
echo bb > d
./legit-status
# for files prev committed then have changes in currdir, not committed or added
echo hiihi > a
./legit-status
# for files prev committed then have changes in currdir and added, not committed yet
./legit-add a
./legit-status
# for files different in index, currdir and latest commit
echo bye > a
./legit-status
# for file previously committed then rm [--cached], status -> deleted
./legit-add a
./legit-commit -m 'third'
./legit-rm a
./legit-status
# removing files in currdir, status -> file deleted
./legit-rm b
# removing files in index, status -> untracked
echo ciao > c
./legit-add c
./legit-commit -m 'fourth'
./legit-rm --cached c
./legit-status
# not show files deleted from index and never committed
echo hi > p
./legit-add p
./legit-rm --force p
./legit-status
# for files prev committed, diff in currdir forcely remove, status - deleted
echo hi > p
./legit-add p
./legit-commit -m 'fifth'
./legit-rm --force p
./legit-status
# for files diff in currdir, index, commit and forcely removed, status - untracked
echo hi > p
./legit-add p
echo bb > p
./legit-rm --cached --force p
./legit-status
