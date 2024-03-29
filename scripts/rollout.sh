#!/bin/bash

set -eux

cd $(dirname $0)
cd ..

BRANCH=${1:-master}

git fetch
git checkout $BRANCH
git merge --ff origin/$BRANCH

bundle install --path ../shared/bundle --jobs=4
bundle exec middleman build

curl 'http://www.google.com/webmasters/sitemaps/ping?sitemap=https%3A%2F%2Fyoucube.jp%2Fsitemap.xml'
