#!/usr/bin/env ruby
file = "lib/#{project.metadata.name}/version.rb"

line = []
line << "module ANSI"
line << "  VERSION = '#{project.version}'"
line << "  DATE = '#{project.verfile.date}'"
project.profile.to_h.each do |key, value|
  line << "  #{key.upcase} = #{value.to_s.inspect}"
end
line << "end"

text = line.join("\n")

if !exist?(file) || read(file) != text
  write(file, text)
  report "Updated #{file}"
else
  report "Already current #{file}"
end

