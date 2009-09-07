module ANSI

  module Terminal

    module_function

    #CHARACTER_MODE = "stty"    # For Debugging purposes only.

    #
    # Unix savvy getc().  (Second choice.)
    #
    # *WARNING*:  This method requires the external "stty" program!
    #
    def get_character( input = STDIN )
      raw_no_echo_mode

      begin
        input.getc
      ensure
        restore_mode
      end
    end

    #
    # Switched the input mode to raw and disables echo.
    #
    # *WARNING*:  This method requires the external "stty" program!
    #
    def raw_no_echo_mode
      @state = `stty -g`
      system "stty raw -echo cbreak isig"
    end

    #
    # Restores a previously saved input mode.
    #
    # *WARNING*:  This method requires the external "stty" program!
    #
    def restore_mode
      system "stty #{@state}"
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

  end

end
