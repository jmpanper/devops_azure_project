FROM nginx:latest
COPY /src/html /usr/share/nginx/html

#documentacion
#EXPOSE 80,22

#CMD["nginx", "-g", "daemon off;"]