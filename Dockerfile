FROM ruby:2.3.0
RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir /dm_log
WORKDIR /dm_log
COPY Gemfile /dm_log/Gemfile
COPY Gemfile.lock /dm_log/Gemfile.lock
RUN bundle install
COPY . /dm_log

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]