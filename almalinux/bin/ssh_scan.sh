#!/bin/bash

ip_with_mask=$(ip -o -4 addr show up primary scope global | awk '{print $4}' | head -n1)  # Linux
# or on macOS:
# ip_with_mask=$(ifconfig $(route get default | grep interface | awk '{print $2}') | grep 'inet ' | awk '{print $2}')

network_prefix=${ip_with_mask%.*}

echo "Scanning $network_prefix.0/24 for open SSH ports..."

check_host() {
  local ip=$1
  ping -c 1 -W 1 $ip &> /dev/null && timeout 1 bash -c "echo > /dev/tcp/$ip/22" &> /dev/null && echo "[OPEN SSH] $ip"
}

for i in $(seq 1 254); do
  check_host "$network_prefix.$i" &
  
  # Limit number of parallel jobs (e.g., max 50)
  while [ $(jobs -r | wc -l) -ge 50 ]; do
    sleep 0.1
  done
done

wait
