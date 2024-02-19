#!/bin/bash

# 输出文件路径
output_file="CN.rsc"

# 输出文件的开头内容
header="/log info \"Loading CN ipv4 address list\"\n/ip firewall address-list remove [/ip firewall address-list find list=CN]\n/ip firewall address-list"

# 创建输出文件并写入开头内容
echo -e $header > $output_file

# 使用curl下载文件并保存为输入文件
curl  -o china.txt -JL  https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/china.txt
# 逐行读取输入文件
while IFS= read -r line
do
  # 将每行的CIDR IP地址添加到输出文件中
  echo ":do { add address=$line list=CN } on-error={}" >> $output_file
done < "china.txt"

echo "生成的文件已保存为$output_file"
