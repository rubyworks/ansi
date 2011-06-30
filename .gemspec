--- !ruby/object:Gem::Specification 
name: ansi
version: !ruby/object:Gem::Version 
  prerelease: 
  version: 1.3.0
platform: ruby
authors: 
- Thomas Sawyer
- Florian Frank
autorequire: 
bindir: bin
cert_chain: []

date: 2011-06-30 00:00:00 Z
dependencies: 
- !ruby/object:Gem::Dependency 
  name: detroit
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
  type: :development
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: qed
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
  type: :development
  version_requirements: *id002
- !ruby/object:Gem::Dependency 
  name: lemon
  prerelease: false
  requirement: &id003 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
  type: :development
  version_requirements: *id003
description: The ANSI project is a collection of ANSI escape code related libraries enabling ANSI code based colorization and stylization of output. It is very nice for beautifying shell output.
email: rubyworks-mailinglist@googlegroups.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- .ruby
- lib/ansi/bbcode.rb
- lib/ansi/chart.rb
- lib/ansi/code.rb
- lib/ansi/columns.rb
- lib/ansi/constants.rb
- lib/ansi/core.rb
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
- lib/ansi.rbz
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
- qed/10_core.rdoc
- qed/applique/output.rb
- test/case_ansicode.rb
- test/case_bbcode.rb
- test/case_mixin.rb
- test/case_progressbar.rb
- HISTORY.rdoc
- LICENSE/BSD-2-Clause.txt
- LICENSE/GPL-2.0.txt
- LICENSE/MIT.txt
- LICENSE/RUBY.txt
- README.rdoc
- NOTICE.rdoc
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
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
requirements: []

rubyforge_project: ansi
rubygems_version: 1.8.2
signing_key: 
specification_version: 3
summary: ANSI codes at your fingertips!
test_files: []

