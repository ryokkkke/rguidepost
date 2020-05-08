FROM ruby:2.7

RUN apt-get update

RUN mkdir /app
WORKDIR /app

ARG GIT_NAME
ARG GIT_EMAIL
RUN git config --global user.name $GIT_NAME
RUN git config --global user.email $GIT_EMAIL

COPY docker/bashrc /root/.bashrc

RUN bundle config --local path vendor/bundle
