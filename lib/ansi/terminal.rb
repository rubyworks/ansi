#
# This library is based of HighLine's SystemExtensions
# by James Edward Gray II.
#
#   Copyright 2006 Gray Productions. All rights reserved.
#
# This is Free Software.  See LICENSE and COPYING for details.

module ANSI

  #
  module Terminal

    module_function

    modes = %w{win32 termios curses stty}

    #
    # This section builds character reading and terminal size functions
    # to suit the proper platform we're running on.  Be warned:  Here be
    # dragons!
    #
    begin
      require 'ansi/terminal/' + (mode = modes.pop)
      CHARACTER_MODE = mode
    rescue LoadError
      retry
    end

    # Get the width of the terminal window.
    def terminal_width
      terminal_size[0]
    end

    # Get the height of the terminal window.
    def terminal_height
      terminal_size[1]
    end

  end

end

