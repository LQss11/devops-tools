#!/bin/bash
## 
# This script can be used to traverse through 
# each directory and subdirectories of a project 
# and print the content of X files in a single file
# This can be useful for small X projects
# that need to be analyzed with ChatGPT
## 

# Default path is the current directory
dir_path=$(pwd)
default_file_extensions=("py" "pyx" "pyw" "pxd" "pxi")

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

# Function to ask the user for additional file extensions
ask_for_file_extensions() {
  read -p "Do you want to specify additional file extensions? (y/n, default: n): " custom_extensions_choice
  custom_extensions_choice=${custom_extensions_choice:-"n"}

  if [ "$custom_extensions_choice" = "y" ]; then
    read -p "Enter additional file extensions (separated by space): " custom_file_extensions
    file_extensions=($custom_file_extensions)
  else
    file_extensions=("${default_file_extensions[@]}")
  fi
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

# List of X file extensions to include

# Create or overwrite the output file
echo -n > "$output_file"

# Traverse the directory and subdirectories recursively
traverse_dir() {
  for file in "$1"/*; do
    base_name=$(basename "$file")

    if [ "$file" = "$output_file" ]; then
      continue  # Skip reading the output file
    fi

    if [ -d "$file" ]; then
      # Check if the directory is empty
      if [ "$(ls -A "$file")" ]; then
        traverse_dir "$file"
      fi
    else
      # Check if the file is an X file
      ext="${file##*.}"
      if [[ " ${file_extensions[@]} " =~ " $ext " ]]; then
        # Remove the directory path prefix from the file path
        file_path="${file#"$dir_path"/}"
        echo "### $file_path ###" >> "$output_file"
        cat "$file" >> "$output_file"
        echo -e "\n" >> "$output_file"
      fi
    fi
  done
}

# Call the traverse_dir function with the input directory path
ask_for_file_extensions
traverse_dir "$dir_path"

echo "Script completed. Output written to $output_file."
