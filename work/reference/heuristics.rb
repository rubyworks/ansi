    def guess_color_availability
      return false unless @output.tty?
      case ENV["TERM"]
      when /term(?:-color)?\z/, "screen"
        true
      else
        return true if ENV["EMACS"] == "t"
        false
      end
    end

    def guess_progress_row_max
      term_width = guess_term_width
      if term_width.zero?
        if ENV["EMACS"] == "t"
          -1
        else
          79
        end
      else
        term_width
      end
    end

    def guess_term_width
      Integer(ENV["COLUMNS"] || ENV["TERM_WIDTH"] || 0)
    rescue ArgumentError
      0
    end

