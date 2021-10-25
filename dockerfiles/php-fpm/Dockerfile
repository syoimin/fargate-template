FROM php:7.4.24-fpm-buster

LABEL email="syoimin.server@gmail.com"

# アプリケーションファイルのコピー
COPY app-files/ /var/www/html/

# config コピー
COPY dockerfile/php-fpm/entrypoint.sh /var/www/html/
# プロセスを root ではなく www-data ユーザで実行

WORKDIR /var/www/html/

# アプリケーションログフォルダの権限変更
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    && /usr/local/bin/docker-php-ext-install \
    pdo_mysql \
    && chown -R www-data: storage \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod 755 /var/www/html/entrypoint.sh \
    && chmod -R 777 ./storage \
    && chmod -R 777 ./bootstrap/cache/


VOLUME /var/www/html

USER www-data

ENTRYPOINT [ "/var/www/html/entrypoint.sh" ]