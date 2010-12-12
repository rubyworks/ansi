--- !ruby/object:Gem::Specification 
name: ansi
version: !ruby/object:Gem::Version 
  hash: 27
  prerelease: false
  segments: 
  - 1
  - 2
  - 2
  version: 1.2.2
platform: ruby
authors: 
- Thomas Sawyer
- Florian Frank
autorequire: 
bindir: bin
cert_chain: []

date: 2010-12-12 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: syckle
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id001
description: ANSI codes at your fingertips!
email: rubyworks-mailinglist@googlegroups.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- Syckfile
- lib/ansi/bbcode.rb
- lib/ansi/code.rb
- lib/ansi/logger.rb
- lib/ansi/mixin.rb
- lib/ansi/progressbar.rb
- lib/ansi/string.rb
- lib/ansi/terminal/curses.rb
- lib/ansi/terminal/stty.rb
- lib/ansi/terminal/termios.rb
- lib/ansi/terminal/win32.rb
- lib/ansi/terminal.rb
- lib/ansi.rb
- test/test_ansicode.rb
- test/test_bbcode.rb
- test/test_mixin.rb
- test/test_progressbar.rb
- PROFILE
- LICENSE
- README.rdoc
- HISTORY
- VERSION
has_rdoc: true
homepage: http://rubyworks.github.com/ansi
licenses: 
- Apache 2.0
post_install_message: 
rdoc_options: 
- --title
- ANSI API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: ansi
rubygems_version: 1.3.7
signing_key: 
specification_version: 3
summary: ANSI codes at your fingertips!
test_files: 
- test/test_ansicode.rb
- test/test_bbcode.rb
- test/test_mixin.rb
- test/test_progressbar.rb
