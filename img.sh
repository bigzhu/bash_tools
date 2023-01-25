#! /bin/bash
# brew install mozjpeg trash
# 避免不要使用 jpeg-turbo 带的 cjpeg, 这是个垃圾
blog_img_path="$HOME/Dropbox/cheese/images"
url_path="./images"
# 剔除输入的文件的路径
file_name=$(basename "$1")
# 分割名字和后缀
name=$(echo "$file_name" | sed -e 's/\.[^.]*$//')
# 后缀
suffix=$(echo "$file_name"  | sed 's/.*\.//')

if [ $suffix == "svg" ]; then
  new_file_name=$file_name
else
  new_file_name="$name.jpg"
fi

# 检查文件是否存在
if [ -f "$blog_img_path/$new_file_name" ]; then
    echo "$blog_img_path/$new_file_name exists." 
    echo "you need check the file name!!!"
    exit 1
fi

if [ $suffix == "svg" ]; then
  mv $1 $blog_img_path/
else
  echo "compress $file_name"
  #/opt/homebrew/opt/mozjpeg/bin/cjpeg -quality 44 "$1" > "$blog_img_path/$new_file_name"
  /opt/homebrew/opt/mozjpeg/bin/cjpeg "$1" > "$blog_img_path/$new_file_name"
fi


# encode file name
#new_file_name=$(echo $new_file_name | python -c "import urllib.parse;print (urllib.parse.quote(input()))")
new_file_name=$(echo $new_file_name | python3 -c "import urllib.parse;print (urllib.parse.quote(input()))")
# markdow 格式
#img="![$new_file_name]($url_path/$new_file_name)"
#img="{{< figure src=\"$url_path/$new_file_name\" width=\"100%\" >}}"
img="![$name]($url_path/$new_file_name)"
# 复制到剪贴板
echo $img | pbcopy
echo "image compress done!"
# 原始文件移动到回收站, 小心使用
if [ $suffix != "svg" ]; then
  trash "$1"
fi
