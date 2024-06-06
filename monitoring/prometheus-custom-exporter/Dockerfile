FROM node:alpine
EXPOSE 80
COPY . .
RUN npm i
ENTRYPOINT ["node","main.js"]
# docker build -t prometheus-custom-exporter .
# docker run -it --rm -p 80:80 --name prometheus-custom-exporter prometheus-custom-exporter