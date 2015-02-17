# Installing Capybara:

# 1. Add capybara to Gemfile:
#
# group :development, :test do
#  gem 'capybara'
# end
#
# 2. Create a file like this one you're reading in spec/support/capybara.rb:

require 'capybara/rails'
require 'capybara/rspec'

# Configures Chrome to be used as the browser for `js: true` feature specs.
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# 3. Start using Capybara. See feature specs in this project for examples.

# Suggested docs
# --------------
# http://www.rubydoc.info/github/jnicklas/capybara/master
# Cheatsheet: https://gist.github.com/zhengjia/428105
# Capybara matchers: http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Matchers
