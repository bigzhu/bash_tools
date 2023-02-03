#!/usr/bin/env bash
# brew install mozjpeg trash
# 避免不要使用 jpeg-turbo 带的 cjpeg, 这是个垃圾
blog_img_path="$HOME/cheese/images"
url_path="images"
# 剔除输入的文件的路径
file_name=$(basename "$1")

# 检查文件是否存在
if [ -f "$blog_img_path/$file_name" ]; then
	echo "$blog_img_path/$file_name exists."
	echo "you need check the file name!!!"
	exit 1
fi
# encode file name
encode_file_name=$(echo $file_name | python3 -c "import urllib.parse;print (urllib.parse.quote(input()))")
markdow_img_link="![$file_name]($url_path/$encode_file_name)"
# 无需压缩的图片类型
if [ "$2" = "svg" ] || [ "$2" = "webp" ] || [ "$2" = "gif" ]; then
	mv $1 $blog_img_path/
else
	#/opt/homebrew/opt/mozjpeg/bin/cjpeg -quality 44 "$1" > "$blog_img_path/$new_file_name"
	echo "compress $file_name"
	/opt/homebrew/opt/mozjpeg/bin/cjpeg "$1" >"$blog_img_path/$file_name"
	trash "$1"
fi

case $(uname) in
Darwin)
	echo $markdow_img_link | pbcopy
	# mac 下才设置, rm 转为移动垃圾箱
	# brew install trash
	# alias rm="trash"
	;;
Linux)
	# commands for Linux go here
	echo $markdow_img_link | xclip -selection clipboard
	;;
esac

echo "image compress done!"
