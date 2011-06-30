require 'ansi/code'

class ::String
  #
  def ansi(*codes)
    ANSI::Code.ansi(self, *codes)
  end

  #
  def ansi!(*codes)
    replace(ansi(*codes))
  end

  #
  def unansi
    ANSI::Code.unansi(self)
  end

  #
  def unansi!
    replace(unansi)
  end
end

