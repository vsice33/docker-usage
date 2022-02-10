FROM php:7.4-fpm
RUN sed -i "s@/deb.debian.org/@/mirrors.tuna.tsinghua.edu.cn/@g" /etc/apt/sources.list
RUN sed -i "s@/security.debian.org/@/mirrors.tuna.tsinghua.edu.cn/@g" /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update

ENV TZ="Asia/Shanghai" DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN apt-get install -y libpq-dev && docker-php-ext-install -j$(nproc) pdo_pgsql
RUN docker-php-ext-install -j$(nproc) bcmath
RUN apt-get install -y libbz2-dev && docker-php-ext-install -j$(nproc) bz2
RUN docker-php-ext-install -j$(nproc) calendar
RUN docker-php-ext-install -j$(nproc) exif
RUN apt-get install -y libicu-dev && docker-php-ext-install -j$(nproc) intl
RUN apt-get install -y libxslt-dev && docker-php-ext-install -j$(nproc) xsl
RUN apt-get install -y libzip-dev && docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) sockets
RUN docker-php-ext-install -j$(nproc) iconv
RUN apt-get install -y libonig-dev && docker-php-ext-install -j$(nproc) mbstring
RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN pecl install swoole && docker-php-ext-enable swoole

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1
RUN composer config -g repos.packagist composer https://mirrors.aliyun.com/composer/

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
