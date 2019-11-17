my ($var_file_path, $func_path) = @ARGV;
my $FH;
my $FH_F;
my @variables = ();
my %pairs = ();
my %var_func_pairs = ();

#print $func_path."\n";
open(FH_F,$func_path) or die "Open func list err!$func_path";
while(my $line=<FH_F>)
{
  chomp $line;
  #print $line."\n";
  my @items = split ":", $line;
  #print $items[0].":".$items[1]."\n";
  $pairs{$items[0]}=$items[1];
}
close($FH_F);

my @func_names = keys %pairs;

#print $var_file_path."\n";
open(FH,$var_file_path) or die "Open var-file list err!$var_file_path";
while(my $line=<FH>)
{
  chomp $line;
  #print $line."\n";
  my @items = split ":", $line;
  foreach my $func (@func_names)
  {
    my @func_files = split " ", $pairs{$func};
    #print $func."\n";
    foreach my $file (@func_files)
    {
      if($items[1] =~ /$file/)
      {
        #print $items[0].":".$items[1].":".$func."\n";
	$var_func_pairs{$items[0].",".$func} = 1;
      }
    }
  }
  #$items[1] =~ /(.+)\/(w+).c$/;
  #print $items[1]."\n";
}
close($FH);

my @result = keys %var_func_pairs;
my %filter_result = ();

foreach my $res_key (@result)
{
#  print $res_key."\n";
  my @items = split ",", $res_key;
  $filter_result{$items[0]}=$filter_result{$items[0]}." ".$items[1];
}

my @final_result = keys %filter_result;

foreach my $final_key (@final_result)
{
  print $final_key.",".$filter_result{$final_key}."\n";
}

