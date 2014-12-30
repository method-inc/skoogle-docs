# require "simplecov"
require "vcr"
require "rspec"
require "factory_girl"

# SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
# SimpleCov.start do
#   add_filter "/spec/"
#   Awful hack to not require minimum coverage if it's not Ruby
#   minimum_coverage(90) unless RUBY_PLATFORM == "java"
# end

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
FactoryGirl.find_definitions
