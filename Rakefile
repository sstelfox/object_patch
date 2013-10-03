
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :environment do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
  require 'object_patch'
end

desc "Run a pry session with the gem code loaded"
task :console => :environment do
  require 'pry'
  pry
end
