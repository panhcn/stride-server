# Use official Ruby base image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install python
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  python3-venv \
  ffmpeg

# Set app directory
WORKDIR /app

# Add Gemfiles first to leverage Docker layer caching
COPY Gemfile Gemfile.lock ./
RUN bundle install

# ✅ Copy python requirements before installing them
COPY python/requirements.txt /app/python/requirements.txt

# ✅ Create Python virtualenv + install MoviePy
RUN set -ex && \
  python3 -m venv /app/python/venv && \
  /app/python/venv/bin/pip install --upgrade pip && \
  /app/python/venv/bin/pip install -r /app/python/requirements.txt
# Add full app
COPY . .

# Expose the default Rails API port
EXPOSE 3000

# Start Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]