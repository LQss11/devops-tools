#!/bin/bash
# redirect input
<file.txt
# redirect output
>file.txt or 1>file.txt
# redirect error
2>error.txt

# Additional commands
somecommand 2>/dev/null
somecommand 1>>output.txt 2>>errors.txt

somecommand >all_output.txt 2>&1

sendmain someone@email.com < emailcontent.txt

# Heredoc approach
sort <<EOF
6
9
2
3
EOF
# Here string approach (basic calculator)
bc <<<1+2+3+4

# comumn arrange file nicely
somecommand | sort | column -t 