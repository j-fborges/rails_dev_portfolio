#!/bin/bash
set -e

echo "===> Setting production environment"
unset BUNDLE_IGNORE_CONFIG
export RAILS_ENV=production
export RACK_ENV=production

echo "===> Cleaning old assets"
rm -rf public/assets
rm -rf tmp/cache

echo "===> Configuring bundler for production"
bundle config set --local deployment true
bundle config set --local without 'development test'
bundle config set --local path 'vendor/bundle'
bundle config set --local jobs 1

echo "===> Installing production gems"
bundle install --jobs=1

echo "===> Precompiling assets"
bundle exec rails assets:precompile

echo "===> Production environment ready."

echo "===> Creating deployment archive"

ZIP_NAME="deploy-$(date +%Y%m%d-%H%M%S).zip"

zip -r $ZIP_NAME . \
  -x "log/*" \
  -x "tmp/*" \
  -x "test/*" \
  -x "spec/*" \
  -x "php-local-server/*" \
  -x ".git/*" \
  -x ".github/*" \
  -x "node_modules/*" \
  -x "vendor/cache/*" \
  -x ".bundle/*" \
  -x "coverage/*" \
  -x "doc/*" \
  -x "*.zip" \
  -x "*.tar.gz"

echo "===> Archive created: $ZIP_NAME"