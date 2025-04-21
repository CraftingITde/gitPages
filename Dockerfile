FROM nginx:1.27.5-alpine

RUN apk add --no-cache --upgrade --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
  git \
  openssh \
  bash \
  php82 \
  php82-fpm \
  supervisor \
  curl

COPY container-fs /

# Make sure files/folders are accessable by the nobody user
RUN chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/cache/nginx && \
  chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /var/log/nginx

USER nobody

WORKDIR /var/www/html

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
