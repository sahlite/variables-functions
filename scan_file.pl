#path, suffix, reg
#my ($path, $suffix, $rp) = @ARGV;
my ($path, $suffix) = @ARGV;
@suffix = split " ", $suffix; # 记得把字符串，转化为数组

sub scan_file
{
  my ($path) = @_;
  my @files = glob($path);
  foreach my $file (@files)
  {
    if(-d $file)
    { # 文件递归下去
      scan_file("$file/*");
    }
    elsif(-f $file)
    {
      foreach my $su (@suffix)
      {
        if ($file =~ /$su$/)
        {
          print $file."\n";
        }
      }
    }
  }
}
scan_file($path);
