#!/bin/bash

# This script serves as an entrypoint for Docker containers
# It ensures the database is ready before starting the application

# Exit immediately if a command exits with a non-zero status
set -e

# Wait for database to be ready before proceeding
# This prevents application errors when trying to connect to a database that isn't ready yet
if [ -n "$DB_HOST" ]; then
  echo "Waiting for Postgres to start..."
  # Loop until pg_isready returns success (database is accepting connections)
  while ! pg_isready -h $DB_HOST -p 5432 -U $DB_USERNAME > /dev/null 2>&1; do
    sleep 1
  done
  echo "Database is ready!"
fi

# Execute the command passed to the script
# This allows the script to act as a wrapper around the main container command
exec "$@"