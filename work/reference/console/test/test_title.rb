#!/usr/bin/env ruby

require "Win32/Console"

a = Win32::Console.new()

title = a.Title()
puts "Old title: \"#{title}\""

a.Title("This is a new title")
title = a.Title()
puts "I just changed the title to '#{title}'"

sleep(5)
