module Term

	module ANSIColor

		@@attributes = [
			[ :clear		,   0 ], 
			[ :reset		,   0 ], 	# synonym for :clear
			[ :bold			,   1 ], 
			[ :dark			,   2 ], 
			[ :italic		,   3 ], 	# not widely implemented
			[ :underline	,   4 ], 
			[ :underscore	,   4 ], 	# synonym for :underline
			[ :blink		,   5 ], 
			[ :rapid_blink	,   6 ], 	# not widely implemented
			[ :negative		,   7 ], 	# no reverse because of String#reverse
			[ :concealed	,   8 ], 
			[ :strikethrough,   9 ], 	# not widely implemented
			[ :black		,  30 ], 
			[ :red			,  31 ], 
			[ :green		,  32 ], 
			[ :yellow		,  33 ], 
			[ :blue			,  34 ], 
			[ :magenta		,  35 ], 
			[ :cyan			,  36 ], 
			[ :white		,  37 ], 
			[ :on_black		,  40 ], 
			[ :on_red		,  41 ], 
			[ :on_green		,  42 ], 
			[ :on_yellow	,  43 ], 
			[ :on_blue		,  44 ], 
			[ :on_magenta	,  45 ], 
			[ :on_cyan		,  46 ], 
			[ :on_white		,  47 ], 
		]	

		@@attributes.each do |c, v|
			eval %Q{
				def #{c.to_s}(string = nil)
					result = "\e[#{v}m"
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
			}
		end

		ColoredRegexp = /\e\[([34][0-7]|[0-9])m/
		def uncolored(string = nil)
			if block_given?
				yield.gsub(ColoredRegexp, '')
			elsif string
				string.gsub(ColoredRegexp, '')
			elsif respond_to?(:to_str)
				gsub(ColoredRegexp, '')
			else
				''
			end
		end
		
		def attributes
			@@attributes.map { |c| c[0] }
		end
		module_function :attributes
		
	end

end
	# vim: set cin sw=4 ts=4:
