# itamaeのサンプル用のプロジェクト

Nginx+PHP70(fpm)+MySQL56+Wordpressするitamae
http://qiita.com/foursue/items/17c1f5607c921aee37a0

## usage

```
$ mkdir ~/projects/ && cd $_
$ git clone git@github.com:foursue/xxv-server.git
$ cd xxv-server
```

### レシピの適用

IPアドレス、PEMファイル、nodeファイルをそれぞれ書いてください。

```
docker run --rm -v $HOME/projects/xxv-server:/usr/src/app -w /usr/src/app ruby:2 sh -c 'bundle install --path vendor/bundle && bundle exec itamae ssh entry.rb --host {{アドレス}} -u root -i secure/{{PEMファイル}} -y nodes/{{nodeファイル}} -n'
```
