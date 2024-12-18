ARG RUBY_VERSION=3.3.4
FROM ruby:$RUBY_VERSION

# Timezone configuration
RUN echo "Africa/Addis_Ababa" > /etc/timezone
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV DATABASE_ADAPTER=${DATABASE_ADAPTER}
ENV DATABASE_ENCODING=${DATABASE_ENCODING}
ENV DATABASE_POOL=${DATABASE_POOL}
ENV DATABASE_USERNAME=${DATABASE_USERNAME}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PORT=${DATABASE_PORT}
ENV DATABASE_NAME=${DATABASE_NAME}
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

# RUN bundle exec rails credentials:edit
RUN bundle exec rails db:create db:migrate db:seed RAILS_ENV=production
# RUN bundle exec rails credentials:edit
# # Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

RUN bundle exec rails assets:precompile

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
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]