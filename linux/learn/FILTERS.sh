find . -perm 777 # exact
find . -perm 777 -o -perm 644 # exact
find . -perm /777 # Any of each
find . -not -name "*.txt"
find . -name "*.txt"
find . -type d -name "example" # d for dir f for file
find . -iname "*.tXt" # Case insensitive 
find . -size 10M # exact value
find . -size -10M # Lesser than
find . -size +10M # More than
find . -mmin -1 # modified in last minute