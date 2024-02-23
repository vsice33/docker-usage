FROM docker.io/bitnami/php-fpm:7.4

COPY ./etc/apt/sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates lsb-release
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y php7.4-dev
RUN apt-get install -y php7.4-mysql php7.4-redis
RUN pecl channel-update pecl.php.net
RUN composer config -g repos.packagist composer https://mirrors.tencent.com/composer/
RUN pecl install yaconf
RUN pecl install SeasLog