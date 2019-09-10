#!/usr/bin/perl -w
# check if .legit repo is initialised
die "legit-merge: error: no .legit directory containing legit repository exists\n" if (! -e "./.legit");

# check if enough command line args
die "usage: legit-merge <branch|commit> -m message\n" if @ARGV < 1;

die "usage: legit-merge <branch|commit> -m message\n" if @ARGV == 2;

if (@ARGV == 3 && $ARGV[1] ne '-m'){
  die "usage: legit-merge <branch|commit> -m message\n";
} elsif (@ARGV == 1){
  die "legit-merge: error: empty commit message\n";
} else {
  $branchname=$ARGV[0];
}

# check for unknown branch
if (-e "./.legit/branches.txt"){
  open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
  $found=0;
  while ($currbranch = <FILE>){
    chomp $currbranch;
    if ($currbranch eq $branchname){
      $found=1;
    }
  }
  if ($found == 0){
    die "legit-merge: error: unknown branch '$branchname'\n";
  }
}
