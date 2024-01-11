envsubst < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.new
mv /etc/nginx/conf.d/default.conf.new /etc/nginx/conf.d/default.conf
