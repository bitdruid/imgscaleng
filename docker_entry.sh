#!/bin/bash

if [ ! -e /app/CONTAINER_CREATED ]; then
  echo "First run, setting up things..."
  touch /app/CONTAINER_CREATED
fi

if [ -z "${PORT}" ]; then
  PORT=8080
fi

cd /app && ng serve --port ${PORT}