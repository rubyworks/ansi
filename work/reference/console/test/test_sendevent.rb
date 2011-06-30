#!/usr/bin/env ruby

require "Win32/Console"


i = 0
begin
while i < 99
  if i == 10
    Win32::Console::GenerateCtrlEvent()
  end
  i = i.next
end
rescue Exception
end

puts "if i=10, then OK!  i=#{i}"
