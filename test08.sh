#!/bin/dash
# test subset1 and subset2
# legit-init,legit-add,legit-commit,legit-log,legit-show,legit-status,legit-rm
./legit-init
echo hi > a
echo bye > b
echo hi > 9%t
./legit-add a b 9%t
./legit-add a b
./legit-commit -m 'commit1'
echo hello > a
./legit-commit -a -m 'commit2'
echo bb > c
./legit-add c
./legit-rm c
./legit-show :c
./legit-commit -m 'commit3'
./legit-rm c
./legit-commit -m 'commit4'
# error as c is removed
./legit-show :c
./legit-show 4:c
# show commit 4 for a and b
./legit-show 4:a
./legit-show 4:b
./legit-log
echo sup > b
./legit-add b
./legit-commit -m 'commit5'
# nothing to commit
echo hello > a
./legit-add a
./legit-commit -m 'commit6'
echo hello > a
./legit-commit -a -m 'commit6'
echo b > a
./legit-add a
echo hii > a
# error with legit-rm since index,commit and currdir diff
./legit-rm a
# force remove
./legit-rm --force a
echo ciao > b
# error since currdir and latest commit diff
./legit-rm b
./legit-rm --force --cached b
./legit-commit -m 'commit6'
./legit-show :b
./legit-status
ls
# rm from currdir, show updated status and allow commit
rm c
# nothing to commmit
./legit-commit -m 'commit7'
./legit-add c
# successful commit
./legit-commit -m 'commit7'
./legit-status
./legit-log
