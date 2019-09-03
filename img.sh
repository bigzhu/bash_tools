#! /bin/bash
blog_img_path="$HOME/Project/sites/blog/cheese/assets/img"
url_path="/assets/img"
# 剔除输入的文件的路径
file_name=$(basename "$1")
name=$(echo "$file_name" | sed -e 's/\.[^.]*$//')
# 后缀
suffix=$(echo "$file_name"  | sed 's/.*\.//')
if [ $suffix == "svg" ]; then
  new_file_name=$file_name
else
  echo "compress $file_name"
  # 删除第一个.后的内容(后缀)
  new_file_name="$name.jpg"
  #echo $file_name, $name, $new_file_name
  # 压缩图片到对应路径, 依赖 brew install mozjpeg
  cjpeg -quality 44 "$1" > "$blog_img_path/$new_file_name"
fi

# markdow 格式
img="![$new_file_name]($url_path/$new_file_name)"
# 复制到剪贴板
echo $img | pbcopy
echo "image compress done!"
# 原始文件移动到回收站, 小心使用
trash "$1"
