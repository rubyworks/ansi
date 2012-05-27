#!/usr/bin/env ruby

#
# Setup QED.
#
config :qed, :profile=>:cov do
  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'log/coverage'
    #add_group "RSpec", "lib/assay/rspec.rb"
  end
end

