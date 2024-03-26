# get all kernel env vars
sysctl -a
# Update env var
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
# persist over restarts
sudo sysctl net.ipv6.conf.default.disable_ipv6

# Create config for sys config (man sysctl.d to get path of configs)
echo "vm.swapiness=29" >/etc/sysctl.d/swap-less.conf
sudo sysctl -p /etc/sysctl.d/swap-less.conf