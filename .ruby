--- 
name: ansi
spec_version: 1.0.0
title: ANSI
contact: rubyworks-mailinglist@googlegroups.com
requires: 
- group: 
  - build
  name: syckle
  version: 0+
resources: 
  repository: git://github.com/rubyworks/ansi.git
  api: http://rubyworks.github.com/ansi/rdoc
  mail: http://groups.google.com/group/rubyworks-mailinglist
  home: http://rubyworks.github.com/ansi
  work: http://github.com/rubyworks/ansi
manifest: 
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
version: 1.2.3
licenses: 
- Apache 2.0
copyright: Copyright (c) 2009 Thomas Sawyer
description: ANSI codes at your fingertips!
summary: ANSI codes at your fingertips!
organization: RubyWorks
authors: 
- Thomas Sawyer
- Florian Frank
created: 2004-08-01
