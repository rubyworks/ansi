#!/usr/bin/env ruby
file = "lib/#{project.metadata.name}/version.rb"

line = []
line << "module ANSI"
line << "  VERSION = '#{project.version}'"
line << "  DATE    = '#{Time.new.strftime("%Y-%m-%d")}'"

#project.profile.to_h.each do |key, value|
#  next if key == "manifest"
#  line << "  #{key.upcase} = #{value.inspect}"
#end

line << "end"

text = line.join("\n")

if !exist?(file) || read(file) != text
  write(file, text)
  report "Updated #{file}"
else
  report "Already current #{file}"
end

