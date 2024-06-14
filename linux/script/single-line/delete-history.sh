#!/bin/bash
# Delete history from 50 - to 100
# for h in $(seq 50 100); do history -d 50; done; history -d $(history 1 | awk '{print $1}')
# Delete starting from 980 to last command executed
FROM=980; TO=$(history | wc -l); for h in $(seq $TO -1 $FROM); do history -d $h; done; history -d $(history 1 | awk '{print $1}')
