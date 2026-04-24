# syntax=docker/dockerfile:1
FROM serversideup/php:8.3-frankenphp

USER root

# Install git and PostgreSQL client libraries with development headers
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y \
    git \
    postgresql-client \
    libpq-dev \
    libpq5 \
    zlib1g-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    && docker-php-ext-install pdo_pgsql pgsql gd intl soap exif xsl

USER www-data

WORKDIR /var/www/html

RUN rm -rf ./*
RUN git clone --depth 1 -b MOODLE_405_STABLE git://git.moodle.org/moodle.git .

ENV PHP_OPCACHE_ENABLE=1 \
    PHP_POST_MAX_SIZE=512M \
    PHP_UPLOAD_MAX_FILE_SIZE=512M \
    PHP_MAX_INPUT_VARS=5000 \
    PHP_DATE_TIMEZONE=Asia/Jakarta \
    NGINX_WEBROOT=/var/www/html/public

COPY --chmod=755 ./entrypoint.d/ /etc/entrypoint.d
