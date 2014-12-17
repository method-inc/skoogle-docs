require "simplecov"
require "vcr"
require "rspec"
require "factory_girl"

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

  config.include FactoryGirl::Syntax::Methods
end

require "skoogle_docs"
