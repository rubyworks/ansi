require 'ansi'
require 'ansi/terminal'

module ANSI

  class Columns

    # Create a column-based layout.
    #
    # list - Multiline String or Array of strings to columnize
    #
    # options[:columns] - number of columns
    # options[:align]   - align :left or :right
    # options[:padding] - space to add to each cell
    #
    # The +format+ block MUST return ANSI codes.
    def initialize(list, options={}, &format)
      self.list = list

      @columns = options[:columns]
      @padding = options[:padding] || 1
      @align   = options[:align]
      #@ansi    = [options[:ansi]].flatten
      @format  = format

      @columns = nil if @columns == 0
    end

    # List layout into columns. Each new line is taken to be 
    # a row-column cell.
    attr_accessor :list

    def list=(list)
      case list
      when ::String
        @list = list.lines.to_a.map{ |e| e.chomp("\n") }
      when ::Array
        @list = list.map{ |e| e.to_s }
      end
    end

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
    #--
    # TODO: Allow #to_s to take options and formating block?
    #++
    def to_s(cols=nil)
      to_s_columns(cols || columns)
    end

    private

    # Layout string lines into columns.
    #
    # TODO: put in empty strings for blank cells
    def to_s_columns(columns=nil)
      lines = list.to_a
      count = lines.size
      max   = lines.map{ |l| l.size }.max
      if columns.nil?
        width = Terminal.terminal_width
        columns = (width / (max + padding)).to_i
      end

      rows = []
      mod = (count / columns.to_f).to_i
      mod += 1 if count % columns != 0

      lines.each_with_index do |line, index|
        (rows[index % mod] ||=[]) << line.strip
      end

      pad = " " * padding
      tmp = template(max, pad)
      str = ""
      rows.each_with_index do |row, ri|
        row.each_with_index do |cell, ci|
          ansi_codes = ansi_formating(cell, ci, ri)
          if ansi_codes.empty?
            str << (tmp % cell)
          else
            str << (tmp % cell).ansi(*ansi_codes)
          end
        end
        str.rstrip!
        str << "\n"
      end
      str
    end

    # Aligns the cell left or right.
    #
    # TODO: Handle centered alignment.
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
          f = @format[col, row]
        else
          f = @format[cell, col, row]
        end
      else
        f = nil
      end
      [f].flatten.compact
    end

  end

end
