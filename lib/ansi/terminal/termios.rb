module ANSI

  module Terminal
    require "termios"             # Unix, first choice.

    module_function

    #CHARACTER_MODE = "termios"    # For Debugging purposes only.

    #
    # Unix savvy getc().  (First choice.)
    #
    # *WARNING*:  This method requires the "termios" library!
    #
    def get_character( input = STDIN )
      old_settings = Termios.getattr(input)

      new_settings                     =  old_settings.dup
      new_settings.c_lflag             &= ~(Termios::ECHO | Termios::ICANON)
      new_settings.c_cc[Termios::VMIN] =  1

      begin
        Termios.setattr(input, Termios::TCSANOW, new_settings)
        input.getc
      ensure
        Termios.setattr(input, Termios::TCSANOW, old_settings)
      end
    end

    # A Unix savvy method to fetch the console columns, and rows.
    def terminal_size
      if /solaris/ =~ RUBY_PLATFORM and
          `stty` =~ /\brows = (\d+).*\bcolumns = (\d+)/
        [$2, $1].map { |c| x.to_i }
      else
        `stty size`.split.map { |x| x.to_i }.reverse
      end
    end

    # Console screen width (taken from progress bar)
    #
    # NOTE: Don't know how portable #screen_width is.
    # TODO: How to fit in to system?
    #
    def screen_width(out=STDERR)
      default_width = ENV['COLUMNS'] || 76
      begin
        tiocgwinsz = 0x5413
        data = [0, 0, 0, 0].pack("SSSS")
        if out.ioctl(tiocgwinsz, data) >= 0 then
          rows, cols, xpixels, ypixels = data.unpack("SSSS")
          if cols >= 0 then cols else default_width end
        else
          default_width
        end
      rescue Exception
        default_width
      end
    end

  end

end