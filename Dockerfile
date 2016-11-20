FROM composer:1.5
COPY composer.json composer.lock /app/
RUN composer install --no-interaction

FROM php:7-apache
RUN apt-get update && apt-get install -y \
    acl \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/project
VOLUME ["/var/www/project/var/cache"]
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
ENV APP_ENV=prod
COPY config/000-default.conf /etc/apache2/sites-available/
COPY --from=0 /app/vendor /var/www/project/vendor
COPY . /var/www/project/
