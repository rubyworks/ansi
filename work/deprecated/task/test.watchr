#!/usr/bin/env ruby

watch( '^test.*/test_.*\.rb'                 )  { |m| test  m[0] }
watch( '^lib/(.*)\.rb'                       )  { |m| test "test/case_#{m[1]}.rb" }
watch( '^lib/ansi/(.*)\.rb'                  )  { |m| test "test/case_#{m[1]}.rb" }
watch( '^test/test_helper\.rb'               )  { test tests }

Signal.trap('QUIT') { test tests  } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

def test(*paths)
  run "ruby-test #{gem_opt} -Ilib:test #{paths.flatten.join(' ')}"
end

def tests
  Dir['test/**/case_*.rb']
end

def run(cmd)
  puts   cmd
  system cmd
end

def gem_opt
  defined?(Gem) ? "-rubygems" : ""
end

