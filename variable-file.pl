my ($files_path, $var_path) = @ARGV; # 获取传入的参数，1-文件列表文件（包含相对路径）,2-变量名文件
my $FH;                              # 文件变量，用于文件列表文件
my $FH_V;                            # 文件变量，用于变量名文件，和文件列表中每个文件
my @variables = ();                  # 变量名存储数组
my %pairs = ();                      # 以‘变量名：文件路径’为键，实现过滤重复组合的目的

open(FH_V,$var_path) or die "Open variables list err!$var_path"; # 打开变量文件
while(my $line=<FH_V>)               # 遍历变量名文件的每一行，每一行为一个变量名
{
  chomp $line;                       #
  push(@variables, $line);           # 追加每一个变量名到数组中
}
close($FH_V);

open(FH,$files_path) or die "Open files list err!$file_path";    # 打开文件列表文件
while(my $file=<FH>)                 # 遍历文件列表文件的每一行，每一行为一个文件名和路径
{
  chomp $file;                       #
  open(FH_V,$file) or die "Open files in list err!$file";        # 打开每一个文件
  while(my $line=<FH_V>)             # 遍历每个文件的每一行
  {
    chomp $line;                     #
    #print "line:".$line."\n";       #
    foreach my $variable (@variables)      # 遍历变量名数组
    {
      #print "variable:".$variable."\n";   #
      if($line=~ /$variable/)              # 匹配当前行是否包含此变量
      {
        $pairs{"$variable:$file"}=1;       # 如果匹配则保存一个表，键为‘变量名：文件路径’，值为1
                                           # 此处为了过滤掉重复的变量名和文件路径组合
	      #print "$variable:$file\n";        #
      }	
    }
    
  }
  close($FH_V);
}
close($FH);

my @last_pairs=keys %pairs;                # 获取键数组

foreach my $pair (@last_pairs)             # 遍历每个数组成员
{
  print $pair."\n";                        # 
}

