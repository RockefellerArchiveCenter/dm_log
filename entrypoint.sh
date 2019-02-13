#!/bin/bash

/usr/bin/wait-for-it.sh db:3306 --

set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /dm_log/tmp/pids/server.pid
rm -f tmp/pids/server.pid

# Set up database
rake db:create
rake db:migrate

rails s -p 3000 -b '0.0.0.0'
