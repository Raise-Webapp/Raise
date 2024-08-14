ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION

# Timezone configuration
RUN echo "Africa/Addis_Ababa" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config

# Create and set working directory
WORKDIR /opt/app

# Copy gemspec and Gemfile
COPY Gemfile Gemfile.lock ./

# Install bundle dependencies
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application files
COPY . .

# Create necessary directories and set permissions
# RUN mkdir -p /storage && chown -R rails:rails /storage

RUN mkdir -p /storage && chown -R 1000:1000 /storage

RUN bundle exec rails db:migrate
RUN bundle exec rails credentials:edit
# # Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/

# # Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# # Run and own only the runtime files as a non-root user for security
# RUN useradd rails --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
# USER rails:rails

# # Create entrypoint script
# RUN echo '#!/bin/bash\nset -e\n\n# Remove a potentially pre-existing server.pid for Rails.\nrm -f /rails/tmp/pids/server.pid\n\n# Then exec the container'"'"'s main process (what'"'"'s set as CMD in the Dockerfile).\nexec "$@"' > /rails/entrypoint.sh && \
#     chmod +x /rails/entrypoint.sh

# # Set the entrypoint
# ENTRYPOINT ["/rails/entrypoint.sh"]

# # Start the server by default, this can be overwritten at runtime
# EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]