#!/bin/sh
# There are multiple alogorithms but the most used are
# md5 and sha216 sha512
ALGORITHM="md5sum"

# In case you want to use sha (256/512) alogirthm
# apt-get update && apt install -y hashalot # Linux
# apk update && apk add coreutils # Alpine
$ALGORITHM $1 | awk '{print $1}' > /tmp/temp1.sha512
$ALGORITHM $2 | awk '{print $1}' > /tmp/temp2.sha512
# You can either use cmp or diff to compare 2 files
diff /tmp/temp1.sha512 /tmp/temp2.sha512