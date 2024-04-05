# Manage Processes
ps auxf
ps -auxf
# Get process id 
pgrep -a sshd

# Prioritize processess with nice value (9 is value of ncie 100 is PID)
nice -n 15 /bin/bash
# Update nice value of sshd process
renice 9 $(ps aux | grep -i sshd | awk '{print $2}' | head -1)
renice 9 $(pgrep sshd)

# get processess nice values
ps lax

# list files that are opened by process
lsof -p $(ps aux | grep -i sshd | awk '{print $2}' | head -1)

# Send signals (kill -l to list all signals)
systemctl status sshd.service
kill -SIGHUP $(pgrep sshd)
kill -1 $(pgrep sshd)

# manage background processes
# run in bg
sleep 300 &
# get current jobs in bg
jobs
# bring back something to fg (ctrl + z to put back to background but stopped)
fg 1
fg $(jobs | grep "sleep 300" | grep -o '[0-9]\+' | head -1)
# resume to bg 
bg 1
bg $(jobs | grep "sleep 300" | grep -o '[0-9]\+' | head -1)