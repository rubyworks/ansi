--- !ruby/object:Gem::Specification 
name: ansi
version: !ruby/object:Gem::Version 
  hash: 21
  prerelease: false
  segments: 
  - 1
  - 2
  - 5
  version: 1.2.5
platform: ruby
authors: 
- Thomas Sawyer
- Florian Frank
autorequire: 
bindir: bin
cert_chain: []

date: 2011-05-05 00:00:00 -04:00
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
- !ruby/object:Gem::Dependency 
  name: ko
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id002
description: The ANSI project is a collection of ANSI escape code related libraries enabling ANSI code based colorization and stylization of output. It is very nice for beautifying shell output.
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
- lib/ansi/diff.rb
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
- lib/ansi.rb
- lib/ansi.yml
- qed/01_ansicode.rdoc
- qed/02_bbcode.rdoc
- qed/03_logger.rdoc
- qed/04_progressbar.rdoc
- qed/05_mixin.rdoc
- qed/06_string.rdoc
- qed/07_columns.rdoc
- qed/08_table.rdoc
- qed/09_diff.rb
- qed/applique/output.rb
- test/case_ansicode.rb
- test/case_bbcode.rb
- test/case_mixin.rb
- test/case_progressbar.rb
- Rakefile
- HISTORY.rdoc
- LICENSE
- README.rdoc
- NOTICE.rdoc
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

