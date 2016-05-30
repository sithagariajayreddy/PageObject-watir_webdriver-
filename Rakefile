require 'rubygems'
require 'bundler'
require 'bundler/setup'
require 'parallel_tests/tasks'
require 'cucumber/rake/task'
require 'fileutils'
#
# require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |features|
  features.cucumber_opts = "features --format progress --format html --out=report/features_report.html"
end

#
Cucumber::Rake::Task.new(:features_ci) do |t|
  t.profile = 'jenkin'
end

Cucumber::Rake::Task.new(:cuke) do |t|
  t.cucumber_opts = %w{--format progress --format json --out=report/features_report.json }
end


task :cleanup do
  puts " ========Deleting old reports ang logs========="
  FileUtils.rm_rf('reports')
  File.delete("cucumber_failures.log") if File.exist?("cucumber_failures.log")
  File.new("cucumber_failures.log", "w")
  Dir.mkdir("reports")
end

task :parallel_run do
  puts "===== Executing Tests in parallel"
  system "bundle exec parallel_cucumber features/ -o \"-p parallel -p pretty\" -n 10"
  puts " ====== Parallel execution finished and cucumber_failure.log created ========="
end

task :rerun do
  if File.size("logs/cucumber_failures.log") == 0
    puts "==== No failures. Everything Passed ========="
  else
    puts " =========Re-running Failed Scenarios============="
    system "bundle exec cucumber @logs/cucumber_failures.log -f pretty"
  end
end

task :bdd_test => [ :cleanup, :parallel_run, :rerun  ]
task :default => :features_ci