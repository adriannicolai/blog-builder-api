# docker build --tag blog_builder_api .
# docker run -p 3000:3000 blog_builder_api

FROM ruby:3.1.2-alpine
RUN apk add --update --virtual \
    runtime-deps \
    mysql-dev \
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    readline \
    libc-dev \
    linux-headers \
    readline-dev \
    file \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /server
COPY /server /server
ADD . /server/
ADD /server/Gemfile /codeapp/
ADD /server/Gemfile.lock /codeapp/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

ENTRYPOINT [ "bin/rails" ]
CMD ["s", "-b", "0.0.0.0", "-e", "staging"]

EXPOSE 3000