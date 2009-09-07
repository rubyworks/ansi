= Clio::String

This is a unit test specification for the Clio::String class.
This class is intended to provide a very convenient way to
output colorful and aligned text to a shell console.

Require the Clio String library.

  require 'clio/string'

Define a few regular strings for comparison.

  @s1 = "Hi how are you."
  @s2 = "Fine thanks."

Define the equivalent Clio strings.

  @c1 = Clio.string("Hi how are you.")
  @c2 = Clio.string("Fine thanks.")

Clio::String#ansi is used to wrap the current string in an
ANSI code *bracket*, ie. prepending with the given ANSI code
and appending with the ANSI escape code.

  y = @c1.ansi(:red)
  x = "\e[31mHi how are you.\e[0m"
  y.to_s.should == x

Some methods are delegated directly to the underying string,
as they do not effect any ANSI codes have been applied.

  y = @c1.ansi(:red).upcase
  x = "\e[31mHI HOW ARE YOU.\e[0m"
  y.to_s.should == x

Shortcut methods are provided for most ANSI Codes, such as
Clio::String#red.

  y = @c1.red
  x = "\e[31mHi how are you.\e[0m"
  y.to_s.should == x

Clio::String#[] will return the character at a gven index.
This works like Ruby 1.9, so no size parameter is needed.

  y = @c1[0]
  x = @s1[0,1]
  y.to_s.should == x

But the size parameter can be given too.

  y = @c1[0,3]
  x = @s1[0,3]
  y.to_s.should == x

A Range works too.

  y = @c1[0..3]
  x = @s1[0..3]
  y.to_s.should == x

Clio::String#+ works just like a regular String.

  y = @c1 + @c2
  x = @s1 + @s2
  y.to_s.should == x

Complex cases with ANSI codes work as expected.

  s1 = Clio.string("a").red
  s2 = Clio.string("b").blue
  y = s1 + s2
  x = "\e[31ma\e[0m\e[34mb\e[0m"
  y.to_s.should == x

Method #sub can replace a substring.

  y = @c1.sub('Hi', 'Hello')
  x = "Hello how are you."
  y.to_s.assert == x

Method #gsub! can replace many substrings.

  s1 = Clio.string("axax").red
  s2 = Clio.string("axax").blue
  y = s1 + s2
  y.to_s.assert == "\e[31maxax\e[0m\e[34maxax\e[0m"
  y.gsub!('x', 'y')
  y.to_s.assert == "\e[31mayay\e[0m\e[34mayay\e[0m"

This specification is not complete, but it is a good start.

