FROM nginx: 1.10.1-alpine
COPY src/html /usr/share/nginx/html

#documentacion
#EXPOSE 80,22

#CMD["nginx", "-g", "daemon off;"]