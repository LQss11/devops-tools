#!/bin/bash

# Function to calculate the checksum
calculate_checksum() {
  algorithm="$1"
  file="$2"
  checksum=$( "$algorithm" "$file" | awk '{ print $1 }' )
  echo "$checksum"
}

# Prompt the user for the algorithm name
read -p "Enter the algorithm name (e.g., md5sum, sha256sum, sha512sum): " algorithm

# Prompt the user for the first file path
read -p "Enter the path to the first file: " file1

# Check if the first file exists
if [ ! -f "$file1" ]; then
  echo "File not found: $file1"
  exit 1
fi

# Prompt the user for the second file path
read -p "Enter the path to the second file: " file2

# Check if the second file exists
if [ ! -f "$file2" ]; then
  echo "File not found: $file2"
  exit 1
fi

# Calculate checksums for both files
checksum1=$(calculate_checksum "$algorithm" "$file1")
checksum2=$(calculate_checksum "$algorithm" "$file2")

# Compare the checksums
if [ "$checksum1" = "$checksum2" ]; then
  echo "Checksums match. The files are identical."
else
  echo "Checksums do not match. The files are different."
fi
