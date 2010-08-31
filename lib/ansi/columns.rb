require 'ansi'
require 'ansi/terminal'

module ANSI

  class Columns

    # Create a column-based layout.
    #
    # string - multiline string to columnize
    #
    # options[:columns] - number of columns
    # options[:align]   - align :left or :right
    # options[:padding] - space to add to each cell
    #
    # The +format+ must return ansi codes.
    def initialize(string, options={}, &format)
      @string  = string
      @columns = options[:columns] || 3
      @padding = options[:padding] || 0
      @align   = options[:align]
      #@ansi    = [options[:ansi]].flatten
      @format  = format
    end

    #
    attr_accessor :string

    #
    attr_accessor :columns

    #
    attr_accessor :padding

    #
    attr_accessor :align

    #
    attr_accessor :format

    #
    def to_s
      if columns
        to_s_columns(columns)
      else
        to_s_auto
      end
    end

    private

    #
    # TODO: put in empty strings for blank cells
    def to_s_columns(columns)
      lines = string.lines.to_a
      count = lines.size
      cols  = []
      mod   = (count / columns.to_f).to_i + 1
      lines.each_with_index do |line, index|
        (cols[index % mod] ||=[]) << line.strip
      end
      max = lines.map{ |l| l.size }.max
      pad = " " * padding
      tmp = template(max, pad)
      str = ""
      cols.each_with_index do |row, c|
        row.each_with_index do |cell, r|
          str << (tmp % cell).ansi(*ansi_formating(cell, c, r))
        end
        str << "\n"
      end
      str
    end

    # TODO: look at the lines and figure out how many columns will fit
    def to_s_auto    
      width = Terminal.terminal_width
    end

    #
    def template(max, pad)
      case align
      when :right, 'right'
        "%#{max}s#{pad}"
      else
        "%-#{max}s#{pad}"
      end
    end

    #
    def ansi_formating(cell, col, row)
      if @format
        case @format.arity
        when 0
          f = @format[]
        when 1
          f = @format[cell]
        when 2 
          f = @format[row, col]
        else
          f = @format[cell, row, col]
        end
      else
        f = nil
      end
      [f].flatten.compact
    end

  end

end
