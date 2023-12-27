#!/bin/bash
## 
# This script can be used to traverse through 
# each directory and subdirectories of a project 
# and print their content in a single file
# This can be useful for small projects
# that need to be analyzed with ChatGPT
## 

# Default values for file extensions and directories to exclude
default_exclude_ext=("png" "jpg" "mp3" "mp4" "md")
default_exclude_dirs=("node_modules" ".git")
exclude_ext=("${default_exclude_ext[@]}")
exclude_dirs=("${default_exclude_dirs[@]}")

# Default path is the current directory
dir_path=$(pwd)

# Function to ask the user for a directory path
ask_for_directory() {
  read -p "Enter the directory path (current: $dir_path): " new_dir_path
  if [ -n "$new_dir_path" ]; then
    if [ ! -d "$new_dir_path" ]; then
      echo "Directory not found!"
      ask_for_directory
    else
      dir_path="$new_dir_path"
    fi
  fi
}

# Function to ask the user for directories to exclude
ask_for_exclude_dirs() {
  read -p "Enter directories to exclude (separated by space, default: ${default_exclude_dirs[*]}): " -a custom_exclude_dirs
  exclude_dirs=("${custom_exclude_dirs[@]:-${default_exclude_dirs[@]}}")
}

# Ask the user if they want to change the directory
read -p "Do you want to change the directory? (y/n, default: n): " change_dir_choice
change_dir_choice=${change_dir_choice:-"n"}

if [ "$change_dir_choice" = "y" ]; then
  ask_for_directory
fi

# Ask the user for the output file name
read -p "Enter the output file name (default: output.txt): " custom_output_file
output_file=${custom_output_file:-"output.txt"}

# Ask the user if they want to exclude specific file extensions
read -p "Do you want to exclude specific file extensions? (y/n, default: n): " exclude_choice
exclude_choice=${exclude_choice:-"n"}

if [ "$exclude_choice" = "y" ]; then
  read -p "Enter file extensions to exclude (separated by space, default: ${default_exclude_ext[*]}): " -a custom_exclude_ext
  exclude_ext=("${custom_exclude_ext[@]:-${default_exclude_ext[@]}}")
fi

# Ask the user if they want to exclude specific directories
read -p "Do you want to exclude specific directories? (y/n, default: n): " exclude_dirs_choice
exclude_dirs_choice=${exclude_dirs_choice:-"n"}

if [ "$exclude_dirs_choice" = "y" ]; then
  ask_for_exclude_dirs
fi

# Create or overwrite the output file
echo -n > "$output_file"

# # Enable dotglob to include hidden files in the loop
# shopt -s dotglob

# Traverse the directory and subdirectories recursively
traverse_dir() {
  for file in "$1"/*; do
    base_name=$(basename "$file")
    echo $base_name
    if [ "$file" = "$output_file" ] || [[ " ${exclude_dirs[@]} " =~ " $base_name " ]]; then
      continue  # Skip reading the output file and excluded directories
    fi

    if [ -d "$file" ]; then
      # Check if the directory is empty
      if [ "$(ls -A "$file")" ]; then
        traverse_dir "$file"
      fi
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

echo "Script completed. Output written to $output_file."

# # Disable dotglob after usage
# shopt -u dotglob
