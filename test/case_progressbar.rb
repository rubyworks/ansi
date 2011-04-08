require 'stringio'
require 'ansi/progressbar'

class TC_ANSI_Progressbar < KO::TestCase

  test "progressbar" do
    stio = StringIO.new
    pbar = ANSI::Progressbar.new("Test Bar", 10, stio) do |b|
      b.style(:title => [:red], :bar=>[:blue])
    end
    10.times do |i|
      sleep 0.1
      pbar.inc
    end
    true
  end

end
