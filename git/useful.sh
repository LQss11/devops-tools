# Git is case insensitive for filenames to solve you can do this
git mv File.txt file.txt

# Update permissions of a file!: 
git update-index --chmod=+x /path/to/file

# Update permissions of a file and add if it was not commited first!: 
git update-index --add --chmod=+x /path/to/file

# For resolving merge conflicts
git mergetool

# Get eol 
git ls-files --eol

# Revert last 5 commits
git revert --no-commit HEAD~5..HEAD
# Revert to a specific commit
git revert --no-commit <commit_hash>..HEAD