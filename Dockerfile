FROM serversideup/php:8.4-fpm-nginx-debian

USER root

# Install git and PostgreSQL client libraries with development headers
RUN apt-get update && apt-get install -y \
    git \
    postgresql-client \
    libpq-dev \
    libpq5 \
    zlib1g-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_pgsql pgsql gd intl soap exif \
    && rm -rf /var/lib/apt/lists/*

USER www-data

WORKDIR /var/www/html

RUN git clone -b MOODLE_500_STABLE git://git.moodle.org/moodle.git .

ENV PHP_OPCACHE_ENABLE=1
ENV NGINX_WEBROOT=/var/www/html
# Configure PHP settings for Moodle
ENV PHP_POST_MAX_SIZE=512M
ENV PHP_DATE_TIMEZONE=Asia/Jakarta
ENV PHP_UPLOAD_MAX_FILE_SIZE=512M
ENV PHP_MAX_INPUT_VARS=5000

COPY --chmod=755 ./entrypoint.d/ /etc/entrypoint.d
COPY --chown=www-data:www-data ./nginx/site-opts.d/http.conf /etc/nginx/site-opts.d/http.conf
