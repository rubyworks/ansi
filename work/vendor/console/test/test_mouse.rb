#!/usr/bin/env ruby

require "Win32/Console"

a = Win32::Console.new()
puts "# of Mouse buttons: #{Win32::Console.MouseButtons}"
