#!/bin/dash
# check legit-rm [--force] [--cached] file

# error if no files given
./legit-rm --cached
./legit-rm --force
./legit-rm --cached --force
./legit-rm --force --cached
# error for wrong flag
./legit-rm -cached
./legit-rm --forced
./legit-rm -ca-
# check that --cached only remove files in index
echo hi > d
./legit-add d
./legit-commit -m 'first'
./legit-rm --cached d
cat d
./legit-show :d
# allow commit after remove without adding
./legit-commit -m 'second'
# check error msg of nothing if commit again
./legit-commit -m 'second'

# check for error msgs when
# removing files with --cached from index that is diff from latest commit
echo bb > a
./legit-add a
./legit-commit -m 'third'
echo hu > a
./legit-add a
./legit-rm --cached a
# remove files where file in index, currdir and latest commit is diff  with --cached
ehco bye > k
./legit-add k
./legit-commit -m 'fourth'
echo hello world > k
./legit-add k
echo sup > k
./legit-rm --cached k
# when one of the file cant be removed, still print error msg
echo hi > p
./legit-add p
./legit-commit -m 'fifth'
echo who > k
./legit-rm p k
./legit-add k
./legit-rm p k


# allow remove files not committed before with --cached
echo bye > m
./legit-add m
./legit-rm --cached m
./legit-commit -m 'sixth'
# allow remove files in currdir diff w index where index is same with latest commit with --cached
echo hi >> k
./legit-rm --cached k
./legit-show :k
# allow remove for file added but not committed with --cached
./legit-add k
./legit-rm --cached k
./legit-show :k

# check no error msgs and allow remove with --force
#removing files from index that is diff from latest commit
echo branchesb > a
./legit-add a
./legit-rm --force a
# remove files not committed before
echo bye > j
./legit-add j
./legit-rm --force j
./legit-add j
./legit-rm --force --cached j
# remove files in currdir diff w index where index is same with latest commit
./legit-commit -m 'third'
echo hi >> k
./legit-rm --force k
# remove files where file in index, currdir and latest commit is diff
./legit-add k
./legit-commit -m 'fourth'
echo hello world > k
./legit-add k
echo sup > k
./legit-rm  --force k
ls
# remove file in currdir which is diff in latest commit
./legit-add k
./legit-commit -m 'fifth'
echo hi world > k
./legit-rm --force k
# allow multiple files to be removed even though user might lose file with --force
echo hi > p
./legit-add p
./legit-commit -m 'sixth'
echo who > bb
./legit-add bb
./legit-rm --force p b
