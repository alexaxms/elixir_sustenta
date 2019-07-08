FROM elixir:1.8-alpine

ENV PORT 4000

WORKDIR /app

RUN apk add --update \
    postgresql-client \
    nodejs nodejs-npm \
    inotify-tools yarn git \
    bash

RUN mix do local.hex --force, local.rebar --force
COPY mix.exs mix.lock ./
RUN MIX_ENV=dev mix do deps.get, deps.compile

COPY assets ./assets
RUN cd assets/ && \
    yarn install && \
    npm install && \
    npm run deploy && \
    cd -

COPY . ./
RUN MIX_ENV=dev mix do compile, phx.digest