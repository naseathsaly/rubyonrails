# syntax=docker/dockerfile:1
FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client
WORKDIR /scheduled_tweets
COPY Gemfile /scheduled_tweets/Gemfile
COPY Gemfile.lock /scheduled_tweets/Gemfile.lock
RUN bundle install
RUN gem install mysql2

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
