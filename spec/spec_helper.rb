require "codeclimate-test-reporter"
require "simplecov"
require "coveralls"
require "vcr"
require "rspec"
require "factory_girl"
require "faker"

CodeClimate::TestReporter.start

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage(90)
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Print the 5 slowest examples and example groups
  config.profile_examples = 5

  # Load Factory Girl methods
  config.include FactoryGirl::Syntax::Methods
end

require "skoogle_docs"
FactoryGirl.find_definitions
