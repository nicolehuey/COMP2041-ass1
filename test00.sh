#!/bin/dash
# check error msg for executing commands  before initializing repository
./legit-add
./legit-log
./legit-commit -m 'first'
./legit-status
./legit-rm a
./legit-show :a
./legit-branch
./legit-checkout
./legit-merge

# check for error msg if extra arguments are given for legit-init
./legit-init a

# check error msg for legit-log,status,branch and show when theres no commits yet o
./legit-init
./legit-log
./legit-show
./legit-status
./legit-branch
