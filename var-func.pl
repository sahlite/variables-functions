my ($var_file_path, $func_path) = @ARGV;                       # 获取传入的参数，1-变量名与文件名配对文件,2-文件名与功能名配对文件
my $FH;                                                        # 文件变量，用于
my $FH_F;                                                      # 文件变量，用于
my @variables = ();                                            #
my %pairs = ();                                                #
my %var_func_pairs = ();                                       #

open(FH_F,$func_path) or die "Open func list err!$func_path";  # 打开文件名与功能名配对文件
while(my $line=<FH_F>)
{
  chomp $line;
  my @items = split ":", $line;                                # 拆分成文件名和功能名，由‘：’连接
  $pairs{$items[0]}=$items[1];                                 # 以功能名为键，以文件名为值
}
close($FH_F);

my @func_names = keys %pairs;                                  # 获取功能名数组

open(FH,$var_file_path) or die "Open var-file list err!$var_file_path"; # 打开变量名与文件名配对文件
while(my $line=<FH>)
{
  chomp $line;
  my @items = split ":", $line;                                # 拆分成变量名和文件名，由‘：’连接
  foreach my $func (@func_names)                               # 遍历功能名数组
  {
    my @func_files = split " ", $pairs{$func};                 # 拆分对应的文件名数组，由‘ ’连接
    foreach my $file (@func_files)                             # 遍历文件名数组
    {
      if($items[1] =~ /$file/)                                 # 根据当前变量名配对的文件名，来检查是否包含当前功能
      {
	      $var_func_pairs{$items[0].",".$func} = 1;              # 将变量名和文件名的配对，转换成和功能名的配对
                                                               # 使用表来过滤掉重复的配对
      }
    }
  }
}
close($FH);

my @result = keys %var_func_pairs;                             # 获取变量名和文件名配对数组
my %filter_result = ();                                        #

foreach my $res_key (@result)                                  # 遍历变量名和文件名配对数组
{
  my @items = split ",", $res_key;                             # 拆分变量名和功能名，由‘，’连接
  $filter_result{$items[0]}=$filter_result{$items[0]}." ".$items[1];     # 最终以变量名为键，以功能名为值，由‘ ’连接
}

my @final_result = keys %filter_result;                        #

foreach my $final_key (@final_result)                          #
{
  print $final_key.",".$filter_result{$final_key}."\n";        # 转换输出格式
}

