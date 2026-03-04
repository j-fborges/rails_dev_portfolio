#!/bin/bash
set -e

echo "===> Switching back to development mode"

unset RAILS_ENV
unset RACK_ENV

echo "===> Removing bundler production config"
bundle config unset deployment
bundle config unset without
bundle config unset path

echo "===> Cleaning vendor bundle"
rm -rf vendor/bundle

echo "===> Reinstalling all gems (including development & test)"
bundle install

echo "===> Removing precompiled assets"
rm -rf public/assets

echo "===> Development environment restored."