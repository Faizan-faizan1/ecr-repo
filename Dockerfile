FROM nginx:latest

COPY /home/ec2-user/myapp/app  /usr/share/nginx/html/index.html

EXPOSE 80
