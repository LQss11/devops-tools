
#!/bin/bash

# Function to check if the swarm is already initialized
is_swarm_initialized() {
  docker info | grep -q "Swarm: active"
}

# Run nmap to find swarm-manager-1
nmap_output=$(nmap -sn 172.10.10.0/24)

# Check if swarm-manager-1 exists in the scan results
if echo "$nmap_output" | grep -q "swarm-manager-1.swarm"; then
  echo "I am not swarm-manager-1"
else
  echo "I am swarm-manager-1"

  # Check if the swarm is already initialized
  if is_swarm_initialized; then
    echo "Swarm is already initialized"
  else
    echo "Initializing the swarm"
    docker swarm init
  fi

  # Get the join tokens
  MANAGER_TOKEN=$(docker swarm join-token manager -q)
  WORKER_TOKEN=$(docker swarm join-token worker -q)

  # Parse the nmap output to identify other nodes
  for host in $(echo "$nmap_output" | grep "Nmap scan report for" | awk '{print $5}'); do
    if [ "$host" != "swarm-manager-1.swarm" ]; then
      if [[ "$host" == *"manager"* ]]; then
        sshpass -p "root" ssh -o StrictHostKeyChecking=no root@$host "docker swarm join --token $MANAGER_TOKEN $(hostname -i):2377"
      elif [[ "$host" == *"worker"* ]]; then
        sshpass -p "root" ssh -o StrictHostKeyChecking=no root@$host "docker swarm join --token $WORKER_TOKEN $(hostname -i):2377"
      fi
    fi
  done
fi
