FROM ruby:2.6.3-alpine

WORKDIR /srv/whiskey

COPY . .

RUN apk update && \
    apk add \
      make \
      g++ \
      sqlite-dev && \
    bundle install
