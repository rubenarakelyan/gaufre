# syntax=docker/dockerfile:1
FROM ruby:3.2.1
RUN apt-get update -qq
WORKDIR /gaufre
COPY Gemfile /gaufre/Gemfile
COPY Gemfile.lock /gaufre/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
