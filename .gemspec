--- !ruby/object:Gem::Specification 
name: ansi
version: !ruby/object:Gem::Version 
  hash: 25
  prerelease: false
  segments: 
  - 1
  - 2
  - 3
  version: 1.2.3
platform: ruby
authors: 
- Thomas Sawyer
- Florian Frank
autorequire: 
bindir: bin
cert_chain: []

date: 2011-04-08 00:00:00 -04:00
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
- .ruby
- lib/ansi/bbcode.rb
- lib/ansi/code.rb
- lib/ansi/columns.rb
- lib/ansi/logger.rb
- lib/ansi/mixin.rb
- lib/ansi/progressbar.rb
- lib/ansi/string.rb
- lib/ansi/table.rb
- lib/ansi/terminal/curses.rb
- lib/ansi/terminal/stty.rb
- lib/ansi/terminal/termios.rb
- lib/ansi/terminal/win32.rb
- lib/ansi/terminal.rb
- lib/ansi/version.rb
- lib/ansi.rb
- test/case_ansicode.rb
- test/case_bbcode.rb
- test/case_mixin.rb
- test/case_progressbar.rb
- PROFILE
- LICENSE
- README.rdoc
- HISTORY
- NOTICE
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
test_files: []

