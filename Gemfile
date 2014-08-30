source 'https://rubygems.org'

ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
gem 'twilio-ruby'

# Use postgresql as the database for Active Record
gem 'pg'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'launchy'
end

group :test do
  gem 'factory_girl_rails'
  gem "rspec-rails", "3.0.1"
  gem 'rspec-collection_matchers', '~> 1.0.0'
  gem "capybara", "2.3.0"
  gem 'timecop'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

# limits the messages to the rails server - no asset load messages
gem 'quiet_assets'

gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

# Heroku gem
gem 'rails_12factor', :group => :production

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
# gem 'bootstrap-sass', '~> 3.0.3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'geocoder'

gem 'angularjs-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'
gem 'sidekiq'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
