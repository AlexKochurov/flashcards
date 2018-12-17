FROM ruby:2.3.8
LABEL maintainer="alex.kochurov@gmail.com"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nano \
  nodejs

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app
ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
