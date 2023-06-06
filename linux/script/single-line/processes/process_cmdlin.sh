COMMAND="tail"
cat /proc/$(ps aux | grep ${COMMAND} | awk '{print $2}' | head -1)/cmdline