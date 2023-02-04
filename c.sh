#!/usr/bin/env bash
#为 cheese 项目的附件功能, 分辨是图片还是文件, 进行压缩或者移动到对应文件
file_type='?'
if [ $# != 1 ]; then
	echo "parameter error"
else
	len3=$(xxd -p -l 3 "$1")
	len4=$(xxd -p -l 4 "$1")
	if [ "$len3" == "ffd8ff" ]; then
		file_type='jpg'
		echo "The type is jpg"
	elif [ "$len4" == "3c3f786d" ]; then
		file_type='svg'
		echo "The type is svg"
	elif [ "$len4" == "89504e47" ]; then
		file_type='png'
		echo "The type is png"
	elif [ "$len4" == "47494638" ]; then
		file_type='gif'
		echo "The type is gif"
	elif [ "$len4" == "52494646" ]; then
		file_type='webp'
		echo "The type is webp"
	elif [ "$len4" == "52617221" ]; then
		file_type='rar'
		echo "The type is rar"
	else
		file_type='?'
		echo "The type is others"
		echo "$len4"
	fi
fi
if [ "$file_type" = "svg" ] || [ "$file_type" = "webp" ] || [ "$file_type" = "gif" ] || [ "$file_type" = "jpg" ] || [ "$file_type" = "png" ]; then
	exec img.sh "$1" "$file_type"
else
	exec file.sh "$1"
fi
