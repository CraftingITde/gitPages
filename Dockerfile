FROM nginx:stable-alpine


#Install Git
RUN apk add --no-cache git openssh bash

#Install PHP
RUN apk --no-cache add php7 php7-fpm 

#Install Misc
RUN apk --no-cache add supervisor curl

# Configure nginx
COPY /files/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY /files/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY /files/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY /files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/cache/nginx && \
  chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /var/log/nginx


USER nobody

# Add application
WORKDIR /var/www/html
COPY --chown=nobody /files/deploy.php /var/www/html/
COPY --chown=nobody /files/gitInit.sh /gitInit.sh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping