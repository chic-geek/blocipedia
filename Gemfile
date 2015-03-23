source 'https://rubygems.org'

## ==========================================================================================
## ALL GEMS
## ==========================================================================================

gem 'rails', '4.2.0'                              # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bootstrap-sass', '~> 3.3.3'                  # Installing Bootstrap-sass for rails
gem 'sass-rails', '~> 5.0'                        # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'                        # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0'                    # Use CoffeeScript for .coffee assets and views
gem 'haml'                                        # Use haml and haml-rails for markup abstraction
gem 'haml-rails'                                  # See above...
gem 'jquery-rails'                                # Use jquery as the JavaScript library
gem 'turbolinks'                                  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0'                          # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0', group: :doc               # bundle exec rake doc:rails generates the API under doc/api.
gem 'devise'                                      # Installing devise
gem 'figaro', '1.1.0'                             # Install figaro for ENV vars
gem 'pundit'                                      # Pundit gives the ability to declare access rights (authorisation)
gem 'stripe'                                      # Integrate the popular Stripe payment gateway API.

# gem 'therubyracer', platforms: :ruby            # See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'bcrypt', '~> 3.1.7'                        # Use ActiveModel has_secure_password
# gem 'unicorn'                                   # Use Unicorn as the app server
# gem 'capistrano-rails', group: :development     # Use Capistrano for deployment


## ==========================================================================================
## GROUPED GEMS
## ==========================================================================================

group :production do
  gem 'pg'                                        # Use PostGres for Heroku production deployment
  gem 'rails_12factor'                            # rails_12factor allows the Rails 4 asset pipeline to run properly on Heroku.
end

group :development do
  gem 'sqlite3'                                   # Use sqlite3 as the database for Active Record
  gem 'faker'                                     # Faker gem creates fake content with which to seed the db
  # gem 'guard-rspec', require: false               # Guard with watch for changes on your app and re-run the tests automagically.
end

group :test do
  gem 'email_spec'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

group :development, :test do
  gem 'byebug'                                    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0'                     # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'                                    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rspec-rails', '~> 3.1'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'capybara'
  gem 'rails-erd'                                 # Rails-ERD; a gem for visually representing db table schema and relationships.
end
