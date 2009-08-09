require 'rake'
require 'rake/testtask'

task :default => [:test]

desc 'Run all unit, functional and integration tests'
task :test do
  errors = %w(test:units test:functionals test:integration).collect do |task|
    begin
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact
  abort "Errors running #{errors}!" if errors.any?
end

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:units'].comment = "Run the unit tests in test/unit"

  Rake::TestTask.new(:functionals) do |t|
    t.libs << "test"
    t.pattern = 'test/functional/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:functionals'].comment = "Run the functional tests in test/functional"

  Rake::TestTask.new(:integration) do |t|
    t.libs << "test"
    t.pattern = 'test/integration/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:integration'].comment = "Run the integration tests in test/integration"
end