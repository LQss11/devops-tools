# Check size
du -sh filename
ls -lh

# Zipping
# Compressfiles
tar --create --file archive.tar a aa
tar cf archive.tar a aa
tar -czvf tar.tar a aa
# Append to compressed tar
tar --append --file archive.tar additionalfile.txt
tar rf archive.tar additionalfile.txt
# Get files in tar
tar tf tar.tar
tar -tf tar.tar
tar --list --file tar.tar
# Extract
tar -xvf tar.tar
tar --extract --file tar.tar
tar xf tar.tar
tar -C /mypath/ -xvf myfile.tar
tar --directory /mypath/ -xvf myfile.tar

# Other compression tools (Read compressed files without decompressed) 
# you can use --decompress instead unzipping commands
# Make sure that compressing delete tar so you can use -k option to keep
file.bz2 | file.gz | file.xz | file.zip
bzip2 | gzip | xz | zip
bunzip2 | gunzip | unxz | unzip
bzcat | zcat | xzcat

# We can use both archive and compress
tar --create --file --gzip archive.tar.gz file1 file2
tar -czf archive.tar.gz file1 file2
tar --create --file --bzip archive.tar.bz2 file1 file2
tar -cjf archive.tar.bz2 file1 file2
tar --create --file --xz archive.tar.xz file1 file2
tar -cJf archive.tar.xz file1 file2

# Best way to do it depending on compresed file extension
tar --create --autocompress --file archive.tar.gz file1 file2
tar caf archive.tar.gz file1 file2
tar xf archive.tar.gz 


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