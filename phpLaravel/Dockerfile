FROM php:7.4-cli

WORKDIR /var/www
#Instalando Pacotes ...
RUN apt update && \
    apt install libzip-dev -y && \
    docker-php-ext-install zip

    
# Instalando Requisitos ...
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"
# Instalando Laravel ...
RUN php composer.phar create-project laravel/laravel laravel

EXPOSE 8080

ENTRYPOINT [ "php", "laravel/artisan", "serve"]

#php artisan serve --help
CMD ["--port=8080" ]