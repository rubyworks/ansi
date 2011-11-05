require 'test_helper'
require 'ansi/mixin'

testcase ANSI::Mixin do

  # TODO: subclass
  class ::String
    include ANSI::Mixin
  end

  unit :red do
    str = "Hello".red
    out = "\e[31mHello\e[0m"
    out.assert == str
  end

  unit :blue do
    str = "World".blue
    out = "\e[34mWorld\e[0m"
    out.assert == str
  end

  unit :display do
    str = "Hello".display(4,10)
    out = "\e[s\e[4;10HHello\e[u"
    out.assert == str
  end

end
