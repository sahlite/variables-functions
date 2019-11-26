my ($path, $suffix) = @ARGV;  # 执行时需要输入 1-要找的文件路径 2-要找的文件类型（扩展名）
@suffix = split " ", $suffix; # 将扩展名字符串转化为数组，每个类型使用空格分割

# 扫描制定路径下的文件，按照是路径还是文件分别处理
sub scan_file
{
  my ($path) = @_;             # 定义路径变量，保存输入信息
  my @files = glob($path);     # 提取路径下的所有文件，生成文件名称的数组
  foreach my $file (@files)    # 遍历文件数组，依次操作
  {
    if(-d $file)               # 路径则递归处理
    {
      scan_file("$file/*");    # 
    }
    elsif(-f $file)            # 文件则根据文件类型筛选
    {
      foreach my $su (@suffix) # 遍历文件扩展名
      {
        if ($file =~ /$su$/)   # 检查文件名结尾是否匹配
        {
          print $file."\n";    # 输出符合的文件名称
        }
      }
    }
  }
}
scan_file($path);              # 处理输入的文件路径
