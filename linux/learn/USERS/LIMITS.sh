# Show number of processes
nproc
# limit user to run no more than 10 procs
myuser - nproc 10
# Limits file (specify which user and how many res limit to give)
sudo vim /etc/securtiy/limits.conf
# Update limit (5000 processes per that user)
ulimit -u 5000