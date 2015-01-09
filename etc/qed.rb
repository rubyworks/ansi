#!/usr/bin/env ruby

QED.configure 'cov' do
  require 'simplecov'
  SimpleCov.command_name 'qed'
  SimpleCov.start do
    add_filter '/demo/'
    coverage_dir 'log/coverage'
    #add_group "Label", "lib/qed/directory"
  end
end

