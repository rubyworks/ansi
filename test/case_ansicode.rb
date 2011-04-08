require 'ansi/code'

class TestANSICode < KO::TestCase

  include ANSI::Code

  test "base methods" do
    str = red + "Hello" + blue + "World"
    out = "\e[31mHello\e[34mWorld"
    out == str
  end

  test "block notation" do
    str = red { "Hello" } + blue { "World" }
    out = "\e[31mHello\e[0m\e[34mWorld\e[0m"
    out == str
  end

end

