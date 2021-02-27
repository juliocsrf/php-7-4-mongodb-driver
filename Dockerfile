FROM php:7.4-fpm

RUN apt-get update
RUN apt-get install -y autoconf pkg-config libssl-dev libicu-dev git zip unzip vim sudo
RUN pecl install mongodb-1.9.0
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install ctype
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install json
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install tokenizer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc

WORKDIR /usr/www
RUN chown -R www-data:www-data /usr/www

RUN mkdir /var/www/.ssh
RUN chown -R www-data:www-data /var/www/.ssh

CMD ["php-fpm"]