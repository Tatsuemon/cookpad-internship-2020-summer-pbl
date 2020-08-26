FROM ruby:2.6.6
LABEL title="cookpad summer instern server"
LABEL version="0.0"

# リポジトリを更新、依存モジュールをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       default-libmysqlclient-dev \
                       nodejs \
                       graphviz \
                       yarn

# 日本語ロケールへの変更
RUN apt-get update && \
    apt-get install -y locales && \
    echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=ja_JP.UTF-8

# ルート直下にコンテナ内作業ディレクトリ作成
RUN mkdir /cookpad-internship-2020-summer-pbl
WORKDIR /cookpad-internship-2020-summer-pbl

# ホストにGemfileと.lockをコピー
ADD Gemfile /cookpad-internship-2020-summer-pbl/Gemfile
ADD Gemfile.lock /cookpad-internship-2020-summer-pbl/Gemfile.lock

# gemをインストール
RUN bundle install

# ホストのアプリケーションディレクトリをコピー
ADD . /cookpad-internship-2020-summer-pbl

RUN mkdir -p tmp/sockets && mkdir -p tmp/pids && yarn install
