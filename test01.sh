#!/bin/dash
# check legit-add

# adding files with invalid filenames
./legit-init
echo hi > %a
./legit-add %a
echo world > b^f
./legit-add b^f
echo hi > 7u@
./legit-add 7u@

#adding file with valid filenames
echo hi > 7-u_p
./legit-add 7-u_p
echo hi > u7.txt
./legit-add u7.txt

# check error for adding files not in currdir
./legit-add fileb

# adding files with no change
echo hi > k
./legit-add k
./legit-commit -m 'msg'
./legit-add k
# nothing to commit 
./legit-commit -m 'msg'
