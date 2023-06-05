# apt-get install tcpdump
# DUMP that captures net trafic on loopback interface and port 2379
tcpdump -i lo -X port 2379
