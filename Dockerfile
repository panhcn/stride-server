# Use official Ruby base image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set app directory
WORKDIR /app

# Add Gemfiles first to leverage Docker layer caching
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add full app
COPY . .

# Expose the default Rails API port
EXPOSE 3000

# Start Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]