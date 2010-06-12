require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/

module ANSI

  # deprecate
  SUPPORTED = true

  # = ANSI Codes
  #
  # Ansi::Code module makes it very easy to use ANSI codes.
  # These are esspecially nice for beautifying shell output.
  #
  #   include Ansi::Code
  #
  #   red + "Hello" + blue + "World"
  #   => "\e[31mHello\e[34mWorld"
  #
  #   red { "Hello" } + blue { "World" }
  #   => "\e[31mHello\e[0m\e[34mWorld\e[0m"
  #
  # == Supported ANSI Commands
  #
  # The following is a list of supported display codes.
  #
  #     save
  #     restore
  #     clear_screen
  #     cls             # synonym for :clear_screen
  #     clear_line
  #     clr             # synonym for :clear_line
  #     move
  #     up
  #     down
  #     left
  #     right
  #
  # The following is a list of supported "style" codes.
  #
  #     clear
  #     reset           # synonym for :clear
  #     bold
  #     dark
  #     italic          # not widely implemented
  #     underline
  #     underscore      # synonym for :underline
  #     blink
  #     rapid_blink     # not widely implemented
  #     negative        # no reverse because of String#reverse
  #     concealed
  #     strikethrough   # not widely implemented
  #
  # The following is a list of supported color codes.
  #
  #     black
  #     red
  #     green
  #     yellow
  #     blue
  #     magenta
  #     cyan
  #     white
  #
  #     on_black
  #     on_red
  #     on_green
  #     on_yellow
  #     on_blue
  #     on_magenta
  #     on_cyan
  #     on_white
  #
  # In addition there are color combinations like +red_on_white+.
  #
  # == Acknowledgement
  #
  # This library is a partial adaptation of ANSIColor by Florian Frank.
  #
  # ANSIColor Copyright (c) 2002 Florian Frank
  #
  # == Developer's Notes
  #
  # TODO: Any ANSI codes left to add? Modes?
  #
  # TODO: up, down, right, left, etc could have yielding methods too?

  module Code
    extend self

    CLEAR      = "\e[0m"
    RESET      = "\e[0m"
    BOLD       = "\e[1m"
    DARK       = "\e[2m"
    ITALIC     = "\e[3m"  # not widely implemented
    UNDERLINE  = "\e[4m"
    UNDERSCORE = "\e[4m"
    BLINK      = "\e[5m"
    RAPID      = "\e[6m"  # not widely implemented
    REVERSE    = "\e[7m"
    NEGATIVE   = "\e[7m"  # alternate to reverse because of String#reverse
    CONCEALED  = "\e[8m"
    STRIKE     = "\e[9m"  # not widely implemented

    BLACK      = "\e[30m"
    RED        = "\e[31m"
    GREEN      = "\e[32m"
    YELLOW     = "\e[33m"
    BLUE       = "\e[34m"
    MAGENTA    = "\e[35m"
    CYAN       = "\e[36m"
    WHITE      = "\e[37m"

    ON_BLACK   = "\e[40m"
    ON_RED     = "\e[41m"
    ON_GREEN   = "\e[42m"
    ON_YELLOW  = "\e[43m"
    ON_BLUE    = "\e[44m"
    ON_MAGENTA = "\e[45m"
    ON_CYAN    = "\e[46m"
    ON_WHITE   = "\e[47m"

    # Save current cursor positon.
    SAVE       = "\e[s"

    # Restore saved cursor positon.
    RESTORE    = "\e[u"

    # Clear to the end of the current line.
    CLEAR_LINE = "\e[K"

    # Clear to the end of the current line.
    CLR        = "\e[K"

    # Clear the screen and move cursor to home.
    CLEAR_SCREEN = "\e[2J"

    # Clear the screen and move cursor to home.
    CLS          = "\e[2J"

    def self.styles
      %w{bold dark italic underline underscore blink rapid reverse negative concealed strike}
    end

    styles.each do |style|
      module_eval <<-END, __FILE__, __LINE__
        def #{style}(string=nil)
          if string
            #warn "use ANSI block notation for future versions"
            return "\#{#{style.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{#{style.upcase}}\#{yield}\#{CLEAR}"
          end
          #{style.upcase}
        end
      END
    end

    def self.colors
      %w{black red green yellow blue magenta cyan white}
    end

    # Dynamically create color methods.

    colors.each do |color|
      module_eval <<-END, __FILE__, __LINE__
        def #{color}(string=nil)
          if string
            #warn "use ANSI block notation for future versions"
            return "\#{#{color.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{#{color.upcase}}\#{yield}\#{CLEAR}"
          end
          #{color.upcase}
        end

        def on_#{color}(string=nil)
          if string
            #warn "use ANSI block notation for future versions"
            return "\#{ON_#{color.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{ON_#{color.upcase}}\#{yield}\#{CLEAR}"
          end
          ON_#{color.upcase}
        end
      END
    end

    # Dynamically create color on color methods.

    colors.each do |color|
      colors.each do |on_color|
        module_eval <<-END, __FILE__, __LINE__
          def #{color}_on_#{on_color}(string=nil)
            if string
              #warn "use ANSI block notation for future versions"
              return #{color.upcase} + ON_#{color.upcase} + string + CLEAR
            end
            if block_given?
              #{color.upcase} + ON_#{on_color.upcase} + yield.to_s + CLEAR
            else
              #{color.upcase} + ON_#{on_color.upcase}
            end
          end
        END
      end
    end

    # Clear code.
    def clear
      CLEAR
    end

    # Reset code.
    def reset
      RESET
    end

    # Save current cursor positon.
    def save
      SAVE
    end

    # Restore saved cursor positon.
    def restore
      RESTORE
    end

    # Clear to the end of the current line.
    def clear_line
      CLEAR_LINE
    end

    # Clear to the end of the current line.
    def clr
      CLR
    end

    # Clear the screen and move cursor to home.
    def clear_screen
      CLEAR_SCREEN
    end

    # Clear the screen and move cursor to home.
    def cls
      CLS
    end

    # Like +move+ but returns to original positon after
    # yielding the block.
    def display(line, column=0) #:yield:
      result = "\e[s"
      result << "\e[#{line.to_i};#{column.to_i}H"
      if block_given?
        result << yield
        result << "\e[u"
      #elsif string
      #  result << string
      #  result << "\e[u"
      end
      result
    end

    # Move cursor to line and column.
    def move(line, column=0)
      "\e[#{line.to_i};#{column.to_i}H"
    end

    # Move cursor up a specificed number of spaces.
    def up(spaces=1)
      "\e[#{spaces.to_i}A"
    end

    # Move cursor down a specificed number of spaces.
    def down(spaces=1)
      "\e[#{spaces.to_i}B"
    end

    # Move cursor left a specificed number of spaces.
    def left(spaces=1)
      "\e[#{spaces.to_i}D"
    end

    # Move cursor right a specificed number of spaces.
    def right(spaces=1)
      "\e[#{spaces.to_i}C"
    end

    ##
    #def position
    #  "\e[#;#R"
    #end

    # Apply ansi codes to block yield.
    #
    #   style(:red, :on_white){ "Valentine" }
    #
    def style(*codes) #:yield:
      s = ""
      codes.each do |code|
        s << "\e[#{TABLE[code]}m"
      end
      s << yield.to_s
      s << CLEAR
    end

    # Alternate term for #style.
    alias_method :color, :style

    #
    def unstyle #:yield:
      if block_given?
        yield.gsub(PATTERN, '')
      else
        ''
      end
    end

    #
    alias_method :uncolor, :unstyle

    # DEPRECATE: This old term will be deprecated.
    def uncolered(string=nil)
      warn "ansi: use #uncolor or #unansi for future version"
      if block_given?
        yield.gsub(PATTERN, '')
      elsif string
        string.gsub(PATTERN, '')
      else
        ''
      end
    end

    # This method is just like #style, except it takes a string
    # rather than a block. The primary purpose of this method
    # is to speed up the String#ansi call.
    #
    #   ansi("Valentine", :red, :on_white)
    #
    def ansi(string, *codes)
      s = ""
      codes.each do |code|
        s << "\e[#{TABLE[code]}m"
      end
      s << string
      s << CLEAR
    end

    # Remove ansi codes from +string+. This method is like unstyle,
    # but takes a string rather than a block.
    def unansi(string)
      string.gsub(PATTERN, '')
    end

    # Regexp for matching style and color codes.
    PATTERN = /\e\[([34][0-7]|[0-9])m/

    # Table of style and color codes.
    TABLE = {
      :clear        =>   0,
      :reset        =>   0,
      :bold         =>   1,
      :dark         =>   2,
      :italic       =>   3,
      :underline    =>   4,
      :underscore   =>   4,
      :blink        =>   5,
      :rapid        =>   6,
      :reverse      =>   7,
      :negative     =>   7,
      :concealed    =>   8,
      :strike       =>   9,
      :black        =>  30,
      :red          =>  31,
      :green        =>  32,
      :yellow       =>  33,
      :blue         =>  34,
      :magenta      =>  35,
      :cyan         =>  36,
      :white        =>  37,
      :on_black     =>  40,
      :on_red       =>  41,
      :on_green     =>  42,
      :on_yellow    =>  43,
      :on_blue      =>  44,
      :on_magenta   =>  45,
      :on_cyan      =>  46,
      :on_white     =>  47
    }
  end

  extend Code
end

#
class String
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

