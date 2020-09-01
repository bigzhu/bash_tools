#! /bin/bash
# 1. try move file to the blog path if not exits
# 2. copy markdown file path to pbcopy
files_path="$HOME/Project/blog/cheese/files/"
file_name=$(basename "$1")
target_file_name=${file_name// /_}
target_file__path="./files/$target_file_name"
if test -f "$files_path$target_file_name"; then
  echo "$files_path$target_file_name exists."
else
  mv "$1" "$files_path$target_file_name"
  echo "$file_name move to $files_path$target_file_name"
fi
markdown_file="[$file_name]($target_file__path)"
echo $markdown_file | pbcopy
