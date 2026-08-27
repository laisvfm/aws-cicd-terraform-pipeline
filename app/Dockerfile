# Use the lightweight Alpine-based Nginx image as the base
FROM nginx:alpine

# Copies the static website files into Nginx's default web root
COPY website/ /usr/share/nginx/html

# Documents that the container listens on port 80 (informational only)
EXPOSE 80

# Runs Nginx in the foreground so the container keeps running
CMD ["nginx", "-g", "daemon off;"]