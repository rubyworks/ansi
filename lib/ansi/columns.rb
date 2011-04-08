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
    # The +format+ block MUST return ANSI codes.
    def initialize(string, options={}, &format)
      @string  = string
      @columns = options[:columns]
      @padding = options[:padding] || 0
      @align   = options[:align]
      #@ansi    = [options[:ansi]].flatten
      @format  = format

      @columns = nil if @columns == 0
    end

    # The string to layout into columns. Each new line is taken to be 
    # a row-column cell.
    attr_accessor :string

    # Default number of columns to display. If nil then the number
    # of coumns is estimated from the size of the terminal.
    attr_accessor :columns

    # Padding size to apply to cells.
    attr_accessor :padding

    # Alignment to apply to cells.
    attr_accessor :align

    # Formating to apply to cells.
    attr_accessor :format

    # Return string in column layout. The number of columns is determined
    # by the `columns` property or overriden by +cols+ argument.
    def to_s(cols=nil)
      to_s_columns(cols || columns)
    end

    private

    # Layout string lines into columns.
    #
    # TODO: put in empty strings for blank cells
    def to_s_columns(columns=nil)
      lines = string.lines.to_a
      count = lines.size
      max   = lines.map{ |l| l.size }.max
      if columns.nil?
        width = Terminal.terminal_width
        columns = (width / (max + padding)).to_i
      end
      cols = []
      mod = (count / columns.to_f).to_i
      mod += 1 if count % columns != 0

      lines.each_with_index do |line, index|
        (cols[index % mod] ||=[]) << line.strip
      end

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

    # Aligns the cell left or right.
    #
    # TODO: Handle justified alignment.
    def template(max, pad)
      case align
      when :right, 'right'
        "%#{max}s#{pad}"
      else
        "%-#{max}s#{pad}"
      end
    end

    # Used to apply ANSI formating to each cell.
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
