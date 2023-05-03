#!/bin/sh

set -e

echo "ENVIRONMENT: $RAILS_ENV"

# check bundle
bundle check || bundle install

# remove any existing PID
rm -f  $APP_PATH/tmp/pids/server.pid

# create and execute migrations in case of any pending case
rake db:create
rake db:migrate

# precompile assets for production
rake assets:precompile

# run anythin by prepending bundle exec to the passed command
bundle exec ${@}