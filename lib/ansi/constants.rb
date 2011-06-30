module ANSI

  # Converts {CHART} and {SPECIAL_CHART} entries into constants.
  module Constants

    require 'ansi/chart'

    CHART.each do |name, code|
      const_set(name.to_s.upcase, "\e[#{code}m")
    end

    SPECIAL_CHART.each do |name, code|
      const_set(name.to_s.upcase, code)
    end

  end

end
