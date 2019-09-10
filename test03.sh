#!/bin/dash
# check legit-rm file

./legit-init
echo hi > a
echo h > b
echo bye > c
./legit-add a b
# error if no committed files yet
./legit-rm a
./legit-commit -m 'first'
# error if no file given
./legit-rm
# remove file not in currdir
./legit-rm filea
# error for invalid filename
echo hi > 2%d
./legit-rm *
# error if file not yet added
./legit-rm c
# error if remove after already been removed
./legit-rm a
./legit-add c
# error msg as user might lose work for files not committed
./legit-rm c
./legit-rm b c
# checking rm for multiple files
./legit-commit -m 'second'
./legit-rm b c
# error when showing files already removed
./legit-show :b
./legit-show :a
./legit-show :c
# check if a,b,c are removed in currdir
ls

# check for error msgs when
# removing files from index that is diff from latest commit
echo bb > a
./legit-add a
./legit-rm a
# remove files not committed before
echo bye > k
./legit-add k
./legit-rm k
# remove files in currdir diff w index where index is same with latest commit
./legit-commit -m 'third'
echo hi >> k
./legit-rm k
# remove files where file in index, currdir and latest commit is diff
./legit-add k
./legit-commit -m 'fourth'
echo hello world > k
./legit-add k
echo sup > k
./legit-rm k
# remove file in currdir which is diff in latest commit
./legit-add k
./legit-commit -m 'fifth'
echo hi world > k
./legit-rm k
# when one of the file cant be removed, still print error msg
echo hi > p
./legit-add p
./legit-commit -m 'sixth'
echo who > k
./legit-rm p k
./legit-add k
./legit-rm p k
