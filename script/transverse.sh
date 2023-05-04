#!/bin/bash
## 
# This file can be used to run through 
# each directory and subdirectories of a project 
# and print their content in a single file
# This can be useful for small projects
# that needs to be analyzed with chatgpt
## 
# Define the array of file extensions to exclude
exclude_ext=( "png" "jpg" "mp3" "mp4" "md" )

# Get the first argument as the directory path
dir_path="$1"

# Check if the directory exists
if [ ! -d "$dir_path" ]; then
  echo "Directory not found!"
  exit 1
fi

# Create an output file to write to
output_file="output.txt"
echo -n > "$output_file"

# Traverse the directory and subdirectories recursively
traverse_dir() {
  for file in "$1"/*; do
    if [ -d "$file" ]; then
      traverse_dir "$file"
    else
      # Check if the file extension should be excluded
      ext="${file##*.}"
      if [[ " ${exclude_ext[@]} " =~ " $ext " ]]; then
        continue
      fi
      # Remove the directory path prefix from the file path
      file_path="${file#"$dir_path"/}"
      echo "### $file_path ###" >> "$output_file"
      cat "$file" >> "$output_file"
      echo -e "\n" >> "$output_file"
    fi
  done
}

# Call the traverse_dir function with the input directory path
traverse_dir "$dir_path"
