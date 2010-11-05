namespace :test do
  desc 'run rspec and cucumber'
  task :coverage => ['spec', 'cucumber']
end

