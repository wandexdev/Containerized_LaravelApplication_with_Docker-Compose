FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html

RUN apt-get update -y && \
	apt install git composer apache2 -y

EXPOSE 80

RUN git clone https://github.com/f1amy/laravel-realworld-example-app.git

WORKDIR /var/www/html/laravel-realworld-example-app

RUN apt-get update && \
    apt-get install -y \
        php8.1 \
        libapache2-mod-php \
        php8.1-dev \
        php8.1-zip \
        php8.1-curl \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-gd \
        php8.1-xml

RUN php -v

COPY laravelhost.conf /etc/apache2/sites-available/laravelhost.conf

RUN a2enmod rewrite
RUN a2ensite laravelhost.conf

RUN composer install --no-interaction

RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

RUN chown -R :www-data /var/www/html/laravel-realworld-example-app \
    && a2enmod rewrite \
    && chmod -R 775 /var/www/html/laravel-realworld-example-app \
    && chmod -R 775 /var/www/html/laravel-realworld-example-app/storage \
    && chmod -R 775 /var/www/html/laravel-realworld-example-app/bootstrap/cache

COPY .env.example .env

RUN php artisan key:generate

COPY web.php routes/web.php

RUN php artisan config:cache

RUN a2dissite 000-default.conf

RUN rm /etc/apache2/sites-available/000-default.conf

RUN a2ensite laravelhost.conf

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"] 
