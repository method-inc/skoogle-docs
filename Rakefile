require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << "rubocop-rspec"
end

require "yard"
YARD::Rake::YardocTask.new(:yard)

# Run this task on our CI server.
task ci: [:spec, :rubocop]
