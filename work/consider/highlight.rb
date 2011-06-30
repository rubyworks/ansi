require 'ansi/code'

file = ARGV.first
text = File.read(file)

close = ANSI::Code.clear

def uncolored(str)
  ANSI::Code.uncolored(str)
end

colors = {
  :dot   => ANSI::Code.red,
  :cash  => ANSI::Code.green,
  :at    => ANSI::Code.cyan,
  :fn    => ANSI::Code.bold + ANSI::Code.blue,
  :cap   => ANSI::Code.blue,
  :sharp => ANSI::Code.white,
  :quote => ANSI::Code.red,
}

work = text.dup

# xxx(
text.gsub!(/(\W)(\w+?)(?=\()/){ $1 + colors[:fn] + $2 + close }

# .xxx
text.gsub!(/\.(\w+?)(?=\W)/){ colors[:dot] + '.' + $1 + close }

# $xxx
text.gsub!(/(\$\w+?)(?=\W)/){ colors[:cash] + $1 + close }

# @xxx
text.gsub!(/(\$\w+?)(?=\W)/){ colors[:at] + $1 + close }

# #xxx
text.gsub!(/\#(.*?)$/){ colors[:sharp] + '#' + uncolored($1) + close }

# XXX
text.gsub!(/([A-Z_]+?)(?=\W)/){ colors[:cap] + $1 + close }

# 'xxx'
text.gsub!(/(['"].*?["'])/){ colors[:quote] + uncolored($1) + close }

# #xxx
text.gsub!(/^(\s+)(\#.*?)$/){ $1 + colors[:sharp] + '#' + uncolored($2) + close }


$stdout << text

