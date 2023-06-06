# Run loop in background
(for i in {1..10}; do echo $i; sleep 5; done) &

# Type this to get all commands running in background
jobs
# Type this to get command in background to foreground
fg