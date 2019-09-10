#!/bin/dash
# commit with no files added
# show error msg : ntg to commit
./legit-init
echo hi > b
./legit-commit -m 'first'

# no newer or updated files to commit
# show error msg : ntg to commit
./legit-add b
./legit-commit -m 'first'
echo hi > b
./legit-add b
./legit-commit -m 'first'

# check for wrong seq of flag in commit command
./legit-commit -m -a 'sec'

#check commit messages for commit -a
./legit-log

# check if commit -a is implemented correctly
echo hi > a
./legit-add a
./legit-commit -a -m '3rd'
./legit-add a
./legit-commit -a -m '3rd'
./legit-add b
./legit-commit -a -m '4th'
echo world > a
echo smtg > b
./legit-commit -a -m '5th'
./legit-show 5:a
./legit-show 5:b
# check commit messages
./legit-log

# commit without single quotes in msg works
echo hi > l
./legit-add l
./legit-commit -m a
./legit-log
