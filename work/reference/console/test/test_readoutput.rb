#!/usr/bin/env ruby

require "Win32/Console"

include Win32::Console::Constants
a = Win32::Console.new(STD_OUTPUT_HANDLE)

puts <<'EOF'
This is a simple
test of test to grab
from the console.
Hopefully this will work
easily and merrily.
This is a simple
test of test to grab
from the console.
Hopefully this will work
easily and merrily.
This is a simple
test of test to grab
from the console.
Hopefully this will work
easily and merrily.
EOF

x1 = a.ReadChar(10,10,10)
x2 = a.ReadAttr(10,10,10)
x3 = a.ReadRect(10,10,20,10)
puts "ReadChar .#{x1}."
puts x2.class, x2.size
print "ReadAttr ."
for i in x2
  print "#{i}|"
end
print "\nReadRect ."

i = 0
while i < x3.length-1
  print "#{x3[i]}"
  i += 2
end
print "\n          "
i = 1
while i < x3.length-1
  print "#{x3[i]}|"
  i += 2
end
print "\n"

#puts "read=",x1
#print "Attributes:",x2

