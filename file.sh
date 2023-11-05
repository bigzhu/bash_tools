#!/usr/bin/env bash
# 1. try move file to the blog path if not exits
# 2. copy markdown file path to pbcopy
files_path="$HOME/Sync/home/cheese/files/"
file_name=$(basename "$1")
target_file_name=${file_name// /_}
target_file__path="file:./files/$target_file_name"
if test -f "$files_path$target_file_name"; then
	if [[ $(md5 -q "$1") = $(md5 -q "$files_path$target_file_name") ]]; then
		echo "$files_path$target_file_name exists."
	else
		# 仅名字一样, 内容不一样
		target_file_name=$$.$target_file_name
		target_file__path="file:./files/$target_file_name"
		mv "$1" "$files_path$target_file_name"
		echo "$file_name move to $files_path$target_file_name"
	fi
else
	mv "$1" "$files_path$target_file_name"
	echo "$file_name move to $files_path$target_file_name"
fi
markdown_file="[$file_name]($target_file__path)"

case $(uname) in
Darwin)
	echo "$markdown_file" | pbcopy
	# mac 下才设置, rm 转为移动垃圾箱
	# brew install trash
	# alias rm="trash"
	;;
Linux)
	# commands for Linux go here
	echo "$markdown_file" | xclip -selection clipboard
	;;
esac
