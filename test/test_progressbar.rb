require 'test/unit'
require 'stringio'
require 'ansi/progressbar'

class TC_ANSI_Progressbar < Test::Unit::TestCase

  def test_progressbar
    stio = StringIO.new
    pbar = ANSI::Progressbar.new("Test Bar", 10, stio) do |b|
      b.style(:title => [:red], :bar=>[:blue])
    end
    10.times do |i|
      sleep 0.1
      pbar.inc
    end
  end

end
