#!/usr/bin/perl -w
# check if .legit repo is initialised
die "legit-checkout: error: no .legit directory containing legit repository exists\n" if (! -e "./.legit");

die "usage: legit-checkout <branch>\n" if @ARGV != 1;

$branch = $ARGV[0];

if ($branch eq "master" && ! -e "./.legit/branches.txt"){
  print("Already on '$branch'\n");
} elsif (-e "./.legit/branches.txt"){
  # find if the branch is created before
  open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
  $found=0;
  # check if branch already exist
  while ($line = <FILE>){
    chomp $line;
    if ($line eq $branch){
      $found=1;
    }
  }
  close FILE;
  if ($found == 1){
    if (! -e "./.legit/current_branch.txt"){
      open FILE,'>',"./.legit/current_branch.txt" or die "Can't open file\n";
      print FILE "$branch";
      close FILE;
    } else {
      # check which branch currently at
      open FILE,'<',"./.legit/current_branch.txt" or die "Can't open file\n";
      while ($currbranch = <FILE>){
        if ($currbranch eq $branch){
          print("Already on '$branch'\n");
          exit 0;
        }
      }
      close FILE;
    }
    # update current branch
    open FILE,'>',"./.legit/current_branch.txt" or die "Can't open file\n";
    print FILE "$branch";
    close FILE;
    print("Switched to branch '$branch'\n");
  } else {
    print("legit-checkout: error: unknown branch '$branch'\n");
  }

} else {
  print("legit-checkout: error: unknown branch '$branch'\n");
}
