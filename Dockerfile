# Use Debian as a parent image
FROM debian:latest

# Update the package index and install necessary packages
RUN apt-get update && apt-get install -y \ 
    ruby \
    ruby-bundler \
    ruby-dev \
    nano \
    systemctl \
    nginx \
    build-essential \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* 

# Set the working directory to /app
WORKDIR /app

# Install bundler and jekyll globally
RUN gem install bundler jekyll

# Copy the Gemfile and Gemfile.lock (if present) to /app in the container
COPY app/Gemfile app/Gemfile.lock* /app/

# Install dependencies for the Jekyll site
RUN bundle install

# Copy the rest of the site files into the container
COPY app/ /app/

# Expose the Jekyll port (4000)
EXPOSE 4000

# Command to run Jekyll when the container starts
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
