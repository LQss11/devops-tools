# Git is case insensitive for filenames to solve you can do this
git mv File.txt file.txt

# Update permissions of a file!: 
git update-index --chmod=+x /path/to/file

# Update permissions of a file and add if it was not commited first!: 
git update-index --add --chmod=+x /path/to/file

# For resolving merge conflicts
git mergetool