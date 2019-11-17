
my ($files_path, $var_path) = @ARGV;
my $FH;
my $FH_V;
my @variables = ();
my %pairs = ();

open(FH_V,$var_path) or die "Open variables list err!$var_path";
while(my $line=<FH_V>)
{
  chomp $line;
  push(@variables, $line);
}
close($FH_V);

open(FH,$files_path) or die "Open files list err!$file_path";
while(my $file=<FH>)
{
  chomp $file;
  open(FH_V,$file) or die "Open files in list err!$file";
  while(my $line=<FH_V>)
  {
    chomp $line;
    #print "line:".$line."\n";
    foreach my $variable (@variables)
    {
      #print "variable:".$variable."\n";
      if($line=~ /$variable/)
      {
        $pairs{"$variable:$file"}=1;
	#print "$variable:$file\n";
      }	
    }
    
  }
  close($FH_V);
}
close($FH);

my @last_pairs=keys %pairs;

foreach my $pair (@last_pairs)
{
  print $pair."\n";
}

