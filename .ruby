--- 
name: ansi
title: ANSI
contact: rubyworks-mailinglist@googlegroups.com
resources: 
  reference: http://rubyworks.github.com/ansi/rdoc
  repository: git://github.com/rubyworks/ansi.git
  mailinglist: http://groups.google.com/group/rubyworks-mailinglist
  development: http://github.com/rubyworks/ansi
  homepage: http://rubyworks.github.com/ansi
requires: 
- group: 
  - build
  name: syckle
  version: 0+
pom_verison: 1.0.0
manifest: 
- Syckfile
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
- test/test_ansicode.rb
- test/test_bbcode.rb
- test/test_mixin.rb
- test/test_progressbar.rb
- PROFILE
- LICENSE
- README.rdoc
- HISTORY
- VERSION
version: 1.2.2
licenses: 
- Apache 2.0
copyright: Copyright (c) 2009 Thomas Sawyer
description: ANSI codes at your fingertips!
summary: ANSI codes at your fingertips!
authors: 
- Thomas Sawyer
- Florian Frank
organization: RubyWorks
created: 2004-08-01
