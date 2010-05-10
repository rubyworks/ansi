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
  # The following is a list of supported codes.
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
  #     display
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
  # This library is a partial adaptation of ANSIColor by Florian Frank.
  #
  # ANSIColor Copyright (c) 2002 Florian Frank
  #
  # TODO: Any ANSI codes left to add? Modes?
  #
  # TODO: up, down, right, left, etc could have yielding methods too

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

    styles = %w{bold dark italic underline underscore blink rapid reverse negative concealed strike}

    styles.each do |style|
      module_eval %{
        def #{color}(string=nil)
          if string
            warn "use ANSI block notation for future versions"
            return "\#{#{style.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{#{style.upcase}}\#{yield}\#{CLEAR}"
          end
          #{style.upcase}
        end
      }
    end

    colors = %w{black red green yellow blue magenta cyan white}

    colors.each do |color|
      module_eval %{
        def #{color}(string=nil)
          if string
            warn "use ANSI block notation for future versions"
            return "\#{#{color.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{#{color.upcase}}\#{yield}\#{CLEAR}"
          end
          #{color.upcase}
        end

        def on_#{color}(string=nil)
          if string
            warn "use ANSI block notation for future versions"
            return "\#{ON_#{color.upcase}}\#{string}\#{CLEAR}"
          end
          if block_given?
            return "\#{ON_#{color.upcase}}\#{yield}\#{CLEAR}"
          end
          ON_#{color.upcase}
        end
      }
    end

    # Dynamically create color on color methods.

    colors.each do |color|
      colors.each do |on_color|
        module_eval %{
          def #{color}_on_#{on_color}
            if block_given?
              #{color.upcase} + ON_#{on_color.upcase} + yield.to_s + CLEAR
            else
              #{color.upcase} + ON_#{on_color.upcase}
            end
          end
        }
      end
    end

    def clear
      CLEAR
    end

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

    #--
    #def position
    #  "\e[#;#R"
    #end
    #++

    # Move curose to line and column.
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
      #elsif respond_to?(:to_str)
      #  result << self
      #  result << "\e[u"
      end
      result
    end

    #
    def style(*codes)
      s = ""
      codes.each do |code|
        s << "\e[#{STYLES[code]}m"
      end
      s << yield
      s << CLEAR
    end

    #
    def unstyle
      if block_given?
        yield.gsub(PATTERN, '')
      #elsif string
      #  string.gsub(ColoredRegexp, '')
      #elsif respond_to?(:to_str)
      #  gsub(ColoredRegexp, '')
      else
        ''
      end
    end

    # old term
    alias_method :uncolored, :unstyle

=begin
    # Define color codes.
    def self.define_ansicolor_method(name,code)
      class_eval <<-HERE, __FILE__, __LINE__
        def #{name.to_s}(string = nil)
          result = "\e[#{code}m"
          if block_given?
            result << yield
            result << "\e[0m"
          elsif string
            result << string
            result << "\e[0m"
          elsif respond_to?(:to_str)
            result << self
            result << "\e[0m"
          end
          return result
        end
      HERE
    end
=end

    PATTERN = /\e\[([34][0-7]|[0-9])m/

    STYLES = {
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

=begin
    @@colors.each do |c, v|
      define_ansicolor_method(c, v)
    end


    #
    def colors
      @@colors.map{ |c| c[0] }
    end

=end

  end

  extend Code

end

#
class String
  #
  def ansi(*codes)
    ANSI::Code.style(*codes){ self }
  end
end

