#!/usr/bin/perl -w
# check if .legit repo is initialised
die "legit-branch: error: no .legit directory containing legit repository exists\n" if (! -e "./.legit");

die "usage: legit-branch [-d] <branch>\n" if @ARGV > 2;

# get branch name or print error msg if input invalid
if (@ARGV == 2 && $ARGV[0] ne '-d'){
    die "usage: legit-branch [-d] <branch>\n"
# if no branchname is given to delete
} elsif (@ARGV == 1 && $ARGV[0] eq '-d'){
  die "legit-branch: error: branch name required\n"
} elsif (@ARGV == 2){
  $branchname=$ARGV[1];
} elsif (@ARGV == 0){
  if (! -e "./.legit/committed" ){
    die ("legit-branch: error: your repository does not have any commits yet\n");
  # list current branch names in sorted order
  } elsif (! -e "./.legit/branches.txt" ){
      open FILE,'>>',"./.legit/branches.txt" or die "Can't open file\n";
      print FILE "master\n";
      close FILE;
      die ("master\n");
  } else {
    open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
    my @lines = <FILE>;
    close FILE;
    print sort @lines;
    exit 0;
  }
} else {
  $branchname=$ARGV[0];
}

# check for valid branchnames
if ($branchname =~ /^([\-])/){
  die "usage: legit-branch [-d] <branch>\n";
# branchname that doesnt starts w aplhanumerical or \
} elsif ($branchname =~ /^([^a-zA-Z0-9\\])/){
  die "legit-branch: error: invalid branch name '$branchname'\n";
# branchname that has other special characters
} elsif ($branchname =~ /([^a-zA-Z_0-9\\-])+/){
  die "legit-branch: error: invalid branch name '$branchname'\n";
#  branch names cannot be entirely numeric
} elsif ($branchname =~ /^([0-9])+$/){
  die "legit-branch: error: invalid branch name '$branchname'\n";
# remove \ in branchname w \
} elsif ($branchname =~ /\//){
  $branchname =~ s/[\\]//g;
}

# delete branch
if ($ARGV[0] eq '-d'){
  $branchname=$ARGV[1];
  if ($branchname eq 'master'){
    die ("legit-branch: error: can not delete branch 'master'\n");
  }
  open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
  $found=0;
  # check if branch already exist
  while ($line = <FILE>){
    chomp $line;
    if ($line eq $branchname){
      $found=1;
      print ("Deleted branch '$branchname'\n");
    }
  }
  close FILE;
  if ($found == 0){
    die ("legit-branch: error: branch '$branchname' does not exist\n");
  } else {
    open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
    @lines = <FILE>;
    foreach my $lines (@lines) {
      chomp $lines;
      next if ($lines =~ m/$branchname/i);
      push @new, $lines;
    }
    close FILE;
    open $f,'>',"./.legit/branches.txt" or die "Can't open file\n";
    foreach $n (@new){
      print $f "$n\n";
    }
    exit 1;
    close $f;
  }

}

# create a textfile to store all the branches
# create new branch
if (! -e "./.legit/branches.txt"){
  open FILE,'>>',"./.legit/branches.txt" or die "Can't open file\n";
  print FILE "$branchname\n";
  print FILE "master\n";
  close FILE;
  if ($branchname eq 'master'){
    die ("legit-branch: error: branch 'master' already exists\n");
  }
} else {
  open FILE,'<',"./.legit/branches.txt" or die "Can't open file\n";
  $found=0;
  # check if branch already exist
  while ($line = <FILE>){
    chomp $line;
    if ($line eq $branchname){
      $found=1;
      die ("legit-branch: error: branch '$branchname' already exists\n");
    }
  }
  close FILE;
  if ($found == 0){
    open FILE,'>>',"./.legit/branches.txt" or die "Can't open file\n";
    print FILE "$branchname\n" ;
    close FILE;
  }

}
