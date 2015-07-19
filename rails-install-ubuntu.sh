#!/bin/bash
 
set -e
 
echo "パッケージを最新にします。パスワードを聞かれることがあります。"
sudo -v
sudo apt-get update -y
 
echo "必要なパッケージをインストールします。"
sudo apt-get install git build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev nodejs libffi-dev -y
 
echo "ImageMagickを追加でインストールします"
sudo apt-get install imagemagick --fix-missing -y
 
echo "Rubyの管理のため、rbenvとruby-buildをインストールします。"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.rbenv.sh
echo 'eval "$(rbenv init -)"' >> ~/.rbenv.sh
echo '. ~/.rbenv.sh' >> ~/.bashrc
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.rbenv.sh
 
echo "Rubyをインストールします！"
rbenv install 2.2.2
rbenv global 2.2.2
 
gem install bundler --no-document
 
echo "Railsをインストールします！"
gem install rails --no-document
 
echo -e "\n- - - - - -\n"
echo -e "インストールされたバージョンが正しいか確認します:\n"
 
echo -n "sqlite は 3.8.1 以上であるべきです:        "
sqlite3 --version | awk '{print $1}'
 
echo -n "rbenv は 0.4.0 以上であるべきです:         "
rbenv --version | awk '{print $2}'
 
echo -n "ruby-build は 20150413 以降であるべきです: "
~/.rbenv/plugins/ruby-build/bin/ruby-build --version | awk '{print $2}'
 
echo -n "Ruby は 2.2.1 以上であるべきです:          "
ruby -v | cut -d " " -f 2
 
echo -n "Rails は 4.2.1 以上であるべきです:         "
rails -v
 
echo -e "\n- - - - - -\n"
 
echo "バージョンは合っていましたか？

おめでとうごさいます！
以下のコマンドが実行できて、無事動作するか確認してみてください:
    $ rails new railsgirls

もし、以下のようなメッセージが出た場合:
    The program 'rails' is currently not installed.
                                                                                 
以下のコマンドを実行しなおしてください。
    source ~/.bashrc

Enjoy Programming!
"
