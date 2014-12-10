source 'https://rubygems.org'
gemspec

group :development do
  gem "pry"
end

group :test do
  gem "coveralls", require: false
  gem "simplecov", require: false
end

group :development, :test do
  gem "guard"
  gem "guard-rspec", require: false
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "guard-rubocop", require: false
end

