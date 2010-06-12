require 'benchmark'
require 'ansi/code'

n = 50000
Benchmark.bmbm(10) do |x|
  x.report("string:"){ n.times{|i| ANSI::Code.red(i.to_s) } }
  x.report("block :"){ n.times{|i| ANSI::Code.red{i.to_s} } }
end

