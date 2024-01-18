# Check size
du -sh filename
ls -lh

# Zipping
# Compressfiles
tar -czvf tar.tar a aa
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

