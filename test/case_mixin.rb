require 'ansi/mixin'

class TestANSIMixin < KO::TestCase

  class ::String
    include ANSI::Mixin
  end

  test "methods" do
    str = "Hello".red + "World".blue
    out = "\e[31mHello\e[0m\e[34mWorld\e[0m"
    out == str
  end

  test "display" do
    str = "Hello".display(4,10)
    out = "\e[s\e[4;10HHello\e[u"
    out == str
  end

end
