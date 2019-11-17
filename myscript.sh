#! /bin/bash
echo "start to scan files"
perl scan_file.pl "./*" ".c" > files_list.txt
echo "scan files finished"
echo "start to pair var- file"
perl variabl-file.pl "./files_list.txt" "variable_lists.txt" > variable-file.txt
echo "pair var-file  finished"
echo "start to pair var-func"
perl var-func.pl "variable-file.txt" "file-function.txt"
echo "pair var-func  finished"
