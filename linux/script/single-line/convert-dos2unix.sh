#!/bin/bash

# Loop through each file in the current directory
find . -type f | while IFS= read -r file; do
    # Check if the file is not within a .git directory
    if [[ "$file" != *".git"* ]]; then
        # Check if the file is a regular file
        if [ -f "$file" ]; then
            # Execute the sed command on the file
            echo "Updating LF $file"
            sed -i $'s/\r$//' "$file"
        fi
    fi
done
