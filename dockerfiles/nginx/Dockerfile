FROM nginx:1.21.3

LABEL email="syoimin.server@gmail.com"

ARG SERVER_NAME_PROD=localhost
ARG SERVER_NAME_STAGE=stage.localhost

ARG PHP_FPM_HOST=php-fpm

# config ファイルのコピー
COPY dockerfile/nginx/config/default.conf /etc/nginx/conf.d/
COPY dockerfile/nginx/config/nginx.conf /etc/nginx/
COPY dockerfile/nginx/config/virtualhost.conf.template /tmp

# root owner を nginx onwer に変更
RUN chown nginx: /var/cache/nginx \ 
    # ステージと本番用の config を配置（非特権ユーザの影響で entypiont 上で環境変数の書き換えができないので両方の config を配置している）
    && ENV_PHP_FPM_HOST=${PHP_FPM_HOST} ENV_SERVER_NAME=${SERVER_NAME_PROD} envsubst '$$ENV_SERVER_NAME, $$ENV_PHP_FPM_HOST' < /tmp/virtualhost.conf.template > /etc/nginx/conf.d/${SERVER_NAME_PROD}.conf \
    && ENV_PHP_FPM_HOST=${PHP_FPM_HOST} ENV_SERVER_NAME=${SERVER_NAME_STAGE} envsubst '$$ENV_SERVER_NAME, $$ENV_PHP_FPM_HOST' < /tmp/virtualhost.conf.template > /etc/nginx/conf.d/${SERVER_NAME_STAGE}.conf

WORKDIR /var/www/html/

VOLUME /var/www/html

# プロセスを root ではなく nginx ユーザで実行
USER nginx

# 特権ユーザ以外は 80 番ポートで Listen できないので変更 
EXPOSE 8080