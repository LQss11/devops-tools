vault operator init | grep Unseal | awk {'print $4'} >/tmp/keys
chmod 400 /tmp/keys 
for i in $(cat /tmp/keys) ;do vault operator unseal $i  ;done