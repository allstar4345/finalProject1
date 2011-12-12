source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3-ruby', '1.3.3', :require => 'sqlite3'
group :production do
  gem 'pg', '~> 0.11.0'
  #gem 'therubyracer-heroku', '~>0.8.1.pre3'
  gem 'faker', '~> 1.0.1'
end

group :development, :test do
   gem 'sqlite3', '1.3.4', :require => 'sqlite3'
   gem 'cucumber', '~> 1.1.0'
end


gem 'gravatar_image_tag', '1.0.0'
gem 'will_paginate', '3.0.2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
#gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
   gem 'rspec-rails', '~> 2.7.0'
   gem 'annotate', '~> 2.4.0'
   gem 'faker', '~> 1.0.1'
end

group :test do
   gem 'rspec', '~> 2.7.0'
   gem 'webrat', '~> 0.7.3'
   gem 'factory_girl_rails', '~> 1.3.0'
   gem 'spork', '0.9.0.rc9'
   #gem 'autotest', '~> 4.4.6'
   #gem 'autotest-growl', '~>0.2.16'
end