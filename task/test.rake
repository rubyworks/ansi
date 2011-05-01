#!/usr/bin/env ruby

task :default => [:test, :qed]

desc "run unit tests"
task :test do
  sh "ko -Ilib test/*.rb"
end

desc "run qed tests"
task :qed do
  sh "qed -Ilib qed/"
end

