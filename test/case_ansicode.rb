require 'test_helper'
require 'ansi/code'

testcase ANSI::Code do

  unit :red do
    str = ANSI::Code.red
    out = "\e[31m"
    out.assert == str
  end

  unit :red => "with block notation" do
    str = ANSI::Code.red { "Hello" }
    out = "\e[31mHello\e[0m"
    out.assert == str
  end

  unit :blue do
    str = ANSI::Code.blue
    out = "\e[34m"
    out.assert == str
  end

  unit :blue => "with block notation" do
    str = ANSI::Code.blue { "World" }
    out = "\e[34mWorld\e[0m"
    out.assert == str
  end

end

