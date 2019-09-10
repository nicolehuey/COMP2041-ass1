#!/bin/dash
# test legit-branch and checkout

# error checking branch when theres no commits
./legit-init
./legit-branch
echo i > a
./legit-add a
./legit-branch

# show current master branch
./legit-commit -m 'first'
./legit-branch
# error creating branch already exists
./legit-branch master
./legit-branch b1
./legit-branch b1
# error msg for invalid branchnames
./legit-branch -f
./legit-branch _p
./legit-branch p.e
./legit-branch p%r
# branch names cannot be entirely numeric
./legit-branch 988
# create new branch
./legit-branch b1
./legit-branch b-1
./legit-branch b_2
# error for branch already exists ignoring \
./legit-branch b\1
# show branch in sorted order
./legit-branch b2
./legit-branch

# delete branch
# error when no branch name given - branch name required
./legit-branch -d
# deleting branch that does not exist
./legit-branch -d b4
# deleting branch
./legit-branch b1
./legit-branch

# legit-checkout
# error when no branch name given
./legit-checkout
# error checking out to nonexistent branch
./legit-checkout newb
# checkout to another branch
./legit-checkout b_2
# error checkout to current branch
./legit-checkout b_2
