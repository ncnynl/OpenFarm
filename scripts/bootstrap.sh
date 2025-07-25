#!/usr/bin/env bash
set -e

# 载入版本变量
source /vagrant/scripts/versions.env

echo ">>> 更新系统"
sudo apt-get update -qq
sudo apt-get upgrade -y -qq

echo ">>> 安装基础工具"
sudo apt-get install -y -qq build-essential curl git gnupg2 software-properties-common

# 安装 RVM 和 Ruby
if ! command -v rvm >/dev/null 2>&1; then
  echo ">>> 安装 RVM"
  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable
fi

source /etc/profile.d/rvm.sh

echo ">>> 安装 Ruby $RUBY_VERSION"
rvm install "$RUBY_VERSION"
rvm use "$RUBY_VERSION" --default

echo ">>> 安装 Bundler"
gem install bundler -N

# 安装 Node.js
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
sudo apt-get install -y nodejs

# 安装 Elasticsearch
echo ">>> 安装 Elasticsearch $ELASTIC_VERSION"
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}-amd64.deb
sudo dpkg -i elasticsearch-${ELASTIC_VERSION}-amd64.deb
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

# 安装 MongoDB 官方仓库
echo ">>> 安装 MongoDB $MONGODB_VERSION"
wget -qO - https://www.mongodb.org/static/pgp/server-${MONGODB_VERSION}.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/${MONGODB_VERSION} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGODB_VERSION}.list
sudo apt-get update -qq
sudo apt-get install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

echo ">>> 安装 Ruby Gems 依赖"
cd /vagrant
bundle install

echo ">>> 运行数据库初始化"
bundle exec rake db:setup

echo ">>> 生成 SECRET_KEY_BASE"
SECRET_KEY=$(bundle exec rake secret)
echo "ENV['SECRET_KEY_BASE'] = '${SECRET_KEY}'" >> config/app_environment_variables.rb

echo ">>> 完成环境搭建"
