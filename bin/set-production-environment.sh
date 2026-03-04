#!/bin/bash
set -e

echo "===> Setting production environment"

export RAILS_ENV=production
export RACK_ENV=production

echo "===> Configuring bundler for shared hosting"

bundle config set --local deployment true
bundle config set --local without 'development test'
bundle config set --local path 'vendor/bundle'
bundle config set --local jobs 1

echo "===> Installing gems from local cache only"

bundle install --local --jobs=1 --retry=0

echo "===> Precompiling assets"

bundle exec rails assets:precompile

echo "===> Touching restart file for Passenger"

mkdir -p tmp
touch tmp/restart.txt

echo "===> Production deploy complete."