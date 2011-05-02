= ANSI::Diff

  require 'ansi/diff'

  a = 'abcYefg'
  b = 'abcXefg'

  diff = ANSI::Diff.new(a,b)

  puts diff.to_s

Try another.

  a = 'abc'
  b = 'abcdef'

  diff = ANSI::Diff.new(a,b)

  puts diff.to_s

And another.

  a = 'abcXXXghi'
  b = 'abcdefghi'

  diff = ANSI::Diff.new(a,b)

  puts diff.to_s

And another.

  a = 'abcXXXdefghi'
  b = 'abcdefghi'

  diff = ANSI::Diff.new(a,b)

  puts diff.to_s

Comparison that is mostly different.

  a = 'abcpppz123'
  b = 'abcxyzzz43'

  diff = ANSI::Diff.new(a,b)

  puts diff.to_s

