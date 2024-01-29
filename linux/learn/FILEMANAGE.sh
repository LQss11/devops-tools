# Check size
du -sh filename
ls -lh

# Zipping
# Compressfiles
tar -czvf tar.tar a aa
tar -C /opt/ -xvf myfile.tar.gz
# Get files in tar
tar -tf tar.tar
# Extract
tar -xvf tar.tar

# Other compression tools (Read compressed files without decompressed)
bzip2 | gzip | xz | zip
bunzip2 | gunzip | unxz | unzip
bzcat | zcat | xzcat


# Find files 
# Locate command depend on a db containing all file paths 
# It might sometimes not work so run updatedb to update it
locate file.txt 

# Permissions
chgrp wheel /my/file/example
chown myuser /my/file/example
chown myuser:wheel /my/file/example

# SUID SGID (s=can execute S=cannot execute s instead of x) STICKYBIT
chmod u+s,g+s,o+t /my/file/example
# SUID file will always be run as default user even if different user
chmod 4664 /my/file/example
# SGID file will always run as default group even if ran by different user group
chmod 2664 /my/file/example
# SUID + SGID bit
chmod 6664 /my/file/example

# Sticky bit (allow only owner to delete)
chmod 1777 /my/file/example
chmod +t /my/file/example

head -10 /my/file/example
tail -n 10 /my/file/example
cut -d ',' -f 1 /my/file/example
sort /my/file/example | uniq
diff -c file1 file2 
# Ignore case
diff -i file1 file2 
# Better comparison
diff -y file1 file2
# Same
sdiff file1 file2

# Pagers
less file1 # Search with /something -> next use n back use shift n (case insensitive type -i to ignore case) q to quit

# Case insensitive 
sed -i 's/disabled/enabled/gi' somefile.conf
# Sed between line 100 and 300
sed -i '100,300s/disabled/enabled/gi' somefile.conf

# Sed delimiters are many for example ### /// ~~~ ||| ,,, ::: 