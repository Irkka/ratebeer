source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
		gem 'sass-rails',   '~> 3.2.3'
		gem 'coffee-rails', '~> 3.2.1'

		# See https://github.com/sstephenson/execjs#readme for more supported runtimes
		# gem 'therubyracer', :platforms => :ruby

		gem 'uglifier', '>= 1.0.3'
		gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

gem 'seed_dump', '0.5.3'
gem 'bcrypt-ruby', '~> 3.0.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
#gem 'debugger', :group => :development
gem 'pry-rails', :group => :development
gem 'httparty'
gem 'rails-settings-cached', '0.2.4'

group :test do
		gem 'factory_girl_rails'
		gem 'capybara'
		gem 'launchy'
		gem 'simplecov', :require => false
		gem 'webmock'
		gem 'selenium-webdriver'
		gem 'database_cleaner', '< 1.1.0'
end

group :development, :test do
		gem 'sqlite3'
		gem 'railroady'
		gem 'rspec-rails', '~> 2.0'
end

group :production do
		gem 'pg'
		gem 'rails_stdout_logging'
		gem 'rails_12factor'
end
