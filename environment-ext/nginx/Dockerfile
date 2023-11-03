FROM nginx:1.22.1-alpine

WORKDIR /usr/share/nginx/html

# Copy main config
COPY nginx.conf /etc/nginx/nginx.conf
# Copy template config using .template suffix (for environment variables subst)
COPY default.conf /etc/nginx/templates/default.conf.template
