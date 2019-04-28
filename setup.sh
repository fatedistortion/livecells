#!/bin/bash
GLOBAL_ENV=.env
if [[ ! -e "$GLOBAL_ENV" ]]; then
    cp .env.example "$GLOBAL_ENV"
fi

SYMFONY_ENV=app/.env
if [[ ! -e "$SYMFONY_ENV" ]]; then
    cp app/.env.test "$SYMFONY_ENV"
fi

docker-compose build

docker-compose up -d
