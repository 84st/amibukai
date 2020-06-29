# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.5.7

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs \
                       yarn         

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
RUN mkdir /app/tmp/sockets
