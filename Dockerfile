FROM ruby:3.1.2-alpine

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.3.25
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

#setup deps for rails
RUN apk -U add --no-cache \
build-base \
git \
postgresql-dev \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
imagemagick \
tzdata \
less \
gcompat \
&& rm -rf /var/cahe/apk/* \
&& mkdir -p $APP_PATH

RUN gem install bundler --version "$BUNDLE_VERSION" \
    && rm  -rf $GEM_HOME/cache/*

WORKDIR $APP_PATH
COPY . $APP_PATH
COPY Gemfile Gemfile.lock ./
EXPOSE $RAILS_PORT
ENTRYPOINT ["bundle", "exec"]