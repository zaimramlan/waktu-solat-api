source 'https://rubygems.org'
ruby '2.7.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'
gem 'pg', '~> 0.19.0'
gem 'puma', '~> 4.3.12'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2.1'
gem 'jquery-rails', '~> 4.2.2'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'httparty', '~> 0.16.2'
gem 'figaro', git: 'https://github.com/zaimramlan/figaro.git'
gem 'nokogiri'
gem 'newrelic_rpm'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'byebug', '~> 9.0', '>= 9.0.6',  platform: :mri
  gem 'listen', '~> 3.0.5'
  gem 'awesome_print', '~> 1.7'
end
