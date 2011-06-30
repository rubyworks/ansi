#!/usr/bin/env ruby

require "Win32/Console"

include Win32::Console::Constants
a = Win32::Console.new(STD_INPUT_HANDLE)

puts "InputChar: Type a phrase then ENTER, please:"

x1 = a.InputChar(1)
puts "Your phrase starts with the character #{x1}"


fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT

a.Mode(fdwMode)

puts
puts "PeekInput: Type a character without ENTER or do something, please:"

while (x1 = a.PeekInput()).size < 1
end

if x1[0] == KEY_EVENT
  puts "You typed #{x1[5]}='#{x1[5].chr}'"
else
  print "You did not typed, but "
  case x1[0]
  when MOUSE_EVENT
    puts "used mouse"
  when WINDOW_BUFFER_SIZE_EVENT
    puts "resize window"
  when MENU_EVENT
    puts "called menu"
  when FOCUS_EVENT
    puts "changed focus"
  else
    puts "...should never get here"
  end
end

puts
puts "Input (as PeekInput keeps event, this reuses PeekInput value):"
x1 = a.Input()
if x1[0] == KEY_EVENT
  puts "You typed #{x1[5]}='#{x1[5].chr}'"
else
  print "You did not typed, but "
  case x1[0]
  when MOUSE_EVENT
    puts "used mouse"
  when WINDOW_BUFFER_SIZE_EVENT
    puts "resize window"
  when MENU_EVENT
    puts "called menu"
  when FOCUS_EVENT
    puts "changed focus"
  else
    puts "...should never get here"
  end
end

