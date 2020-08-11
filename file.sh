#! /bin/bash
# 1. try move file to the blog path if not exits
# 2. copy markdown file path to pbcopy
files_path="$HOME/Project/blog/cheese/files/"
file_name=$(basename "$1")
path_file="./files/$file_name"
if test -f "$files_path$file_name"; then
  echo "$files_path$file_name exists."
else
  mv $1 $files_path
  echo "file move to $path_file"
fi
markdown_file="[$file_name]($path_file)"
echo $markdown_file | pbcopy
