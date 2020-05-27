# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.5.7

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs           

# 作業ディレクトリの作成、設定
RUN mkdir /app
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照

WORKDIR /app

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# Gemfileのbundle install
RUN gem install bundler && bundle install
ADD . /app
