# 自分的 ベスト Fargate Cloudformation 管理方法

## 構成図

構成（AWS 公式 Fargate サンプルと同等 https://aws.amazon.com/jp/cdp/ec-container/）
![Fargate 構成図](/ecs.png)

## アプリケーション

Laravel 環境を想定

- php-fpm
- nginx

## docker-compose を使ってローカル環境で試す場合

### アプリケーションファイルのコピー

app-files にコピーする

### ビルド

```sh
docker-compose build --build-arg PHP_FPM_HOST=php-fpm --build-arg SERVER_NAME=localhost
```

### 起動

```sh
docker-compose up
```

### ゴミイメージ削除

```sh
docker image prune
```

## その他

ps コマンドのインストール

```sh
apt update && apt install -y procps
```

## 工夫点・妥協点・問題点

### 工夫点

- root を取られないのように nginx や php-fpm の PID 1 は root ではなくそれぞれ nginx www-data ユーザで実行
- 万一乗っ取られてもファイルの所有者を root にし、書き込み権限を剥奪しているのでリソースの書き換えはおこならないようになっている

### 妥協点

- 非特権ユーザでプロセスを実行したため entrypoint.sh で config の書き換えやファイルの書き換えができない。
  - したがって nginx の config はステージと本番両方イメージに含まれている。

### 問題点

- composer install が mysql との接続が必須となってるため Dockerfile 内で実行できなかった。
  - つまりコンテナが立ち上がるたびに composer install が走るのでコンテナのスケールアウトに時間がかかってしまう。
