# syntax=docker/dockerfile:1
FROM alpine:latest
RUN apk --no-cache add curl jq
WORKDIR /app/
COPY prepare-cyberchef.sh /
RUN chmod +x /prepare-cyberchef.sh && sh -c /prepare-cyberchef.sh

FROM nginx:alpine
EXPOSE 8080
COPY --from=0 /app/ /usr/share/nginx/html/
# Set the container to listen on port 8080 -- this is for easy CloudRun deployment
CMD ["/bin/sh", "-c", "sed -i 's/listen  .*/listen 8080;/g' /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
