require 'test/unit'
require 'ansi/mixin'

class TestANSIMixin < Test::Unit::TestCase

  class ::String
    include ANSI::Mixin
  end

  def test_methods
    str = "Hello".red + "World".blue
    out = "\e[31mHello\e[0m\e[34mWorld\e[0m"
    assert_equal(out, str)
  end

  def test_display
    str = "Hello".display(4,10)
    out = "\e[s\e[4;10HHello\e[u"
    assert_equal(out, str)
  end

end
