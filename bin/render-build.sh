#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
bundle install

# Precompile assets
bundle exec rails assets:precompile

# Clean up old assets
bundle exec rails assets:clean

# Ensure the database is set up
bundle exec rails db:create db:migrate

# Seed the database
bundle exec rails db:seed

# Run tests (if using RSpec)
if command -v rspec > /dev/null; then
  bundle exec rspec
fi
