# ^ Anything that starts with example
cat file.txt | grep '^example'
# $ Anything that ends with example
cat file.txt | grep 'example$'
# . any word between 2 characters (for example pentest, text tent ... will be matched)
cat file.txt | grep 'te.t'
# -w just to match full world (for example pentest is ignored sice it s a containing word but test is not ignored )
cat file.txt | grep 'te.t'

# \ escaping when regex special characters 
cat file.txt | grep '\.'
cat file.txt | grep '\$'
cat file.txt | grep '\*'

# .* Anything between
cat file.txt | grep '/.*/'
cat file.txt | grep '#.*#'
# .* Anything after
cat file.txt | grep 'example.*'
# .* Anything before
cat file.txt | grep '.*example'

# Exist at least once
cat file.txt | grep '0\+'

# E grep
# For example here egrep knows + is a special character no need for /
# grep -E = egrep command
cat file.txt | grep -E '0+'
# At least 3 zeors
cat file.txt | grep -E '0{3,}'
# x= with at max 3 zeros after it
cat file.txt | grep -E 'x=0{,3}'
# x= with at min 2 and max 10 zeros after it
cat file.txt | grep -E 'x=0{2,10}'
# x= with at exactly 3 zeros after it
cat file.txt | grep -E 'x=0{3}'

# x is optional since it has ? after it
cat file.txt | grep -E 'somex?word'

# | or condition
cat file.txt | grep -E 'somex?words?|somen?words?'

# [a-z] [0-9] [xyzabde]  range or set
cat file.txt | grep -E 'c[au]t'
# example brackets
grep -Er '/dev/[a-z]*[0-9]?' /dev/
# () to multiply regex
grep -Er '/dev/([a-z]|[A-Z]*[0-9]?)*' /dev/

# Negate (get all that has http)
cat somefile.conf | grep -E 'http[^s]'
cat somefile.conf | grep -E '/[^a-z]'