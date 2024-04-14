apt install nginx
vim /etc/nginx/sites-available/proxy.conf

# there is the path where to activate and deactivate configs here is an example
# make sure links are between sites-available to sites-enabled
ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/proxy.conf

# Example
server {
    listen 80;
    location /images {
        proxy_pass http://1.1.1.1;
        include /etc/nginx/proxy_params;
    }
}
# proxy_params (Set proxy headers to relay client information securely.)
proxy_set_header Host $http_host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;


# Load Balance
upstream myserver {
    least_conn;
    server 1.2.3.4 weight=3 down;
    server 5.6.7.8;
    server 111.22.33.44 backup;
}