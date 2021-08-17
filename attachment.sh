#! /bin/bash
blog_path="$HOME/Dropbox/cheese/assets/attachment"
url_path="/assets/attachment"
# 剔除输入的文件的路径
file_name=$(basename "$1")

# 
mv "$1" "$blog_path/$file_name"
# encode file name
#new_file_name=$(echo $new_file_name | python -c "import urllib.parse;print (urllib.parse.quote(input()))")
encode_file_name=$(echo $file_name | python3 -c "import urllib.parse;print (urllib.parse.quote(input()))")
img="![](https://bigzhu.net$url_path/$encode_file_name)"
# 复制到剪贴板
echo $img | pbcopy
echo "attachment move done!"
