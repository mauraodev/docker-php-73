FROM php:7.3-apache

RUN apt-get update \
  && apt-get install -y \
  libpq-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  zlib1g-dev \
  libicu-dev \
  libxml2-dev \
  libmemcached-dev \
  libssl-dev \
  curl \
  git-core \
  ruby \
  g++ \
  libzip-dev \
  zip

RUN docker-php-ext-install zip gd soap exif mysqli pdo_mysql

RUN curl https://phar.phpunit.de/phpunit.phar -L > phpunit.phar \
  && chmod +x phpunit.phar \
  && mv phpunit.phar /usr/local/bin/phpuni

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY default-vhost.conf /etc/apache2/sites-available/default.conf
RUN a2dissite 000-default.conf && a2ensite default.conf && a2enmod rewrite

COPY php.ini.development /usr/local/etc/php/php.ini

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data