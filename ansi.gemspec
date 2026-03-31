Gem::Specification.new do |s|
  s.name        = 'ansi'
  s.version     = '1.6.0'
  s.summary     = 'ANSI at your fingertips!'
  s.description = 'The ANSI project is a superlative collection of ANSI escape code related ' \
                  'libraries enabling ANSI colorization and stylization of console output. Byte for ' \
                  'byte ANSI is the best ANSI code library available for the Ruby programming language.'

  s.authors     = ['Thomas Sawyer', 'Florian Frank']
  s.email       = ['transfire@gmail.com']

  s.homepage    = 'https://github.com/rubyworks/ansi'
  s.license     = 'BSD-2-Clause'

  s.required_ruby_version = '>= 3.1'

  s.files       = Dir['lib/**/*', 'LICENSE.txt', 'README.md', 'HISTORY.md', 'NOTICE.md', 'demo/**/*']
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '>= 13'
  s.add_development_dependency 'qed', '>= 2.9'
  s.add_development_dependency 'ae', '>= 1.8'
end
