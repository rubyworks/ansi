--- 
spec_version: 1.0.0
replaces: []

loadpath: 
- lib
name: ansi
repositories: {}

conflicts: []

engine_check: []

title: ANSI
contact: rubyworks-mailinglist@googlegroups.com
resources: 
  repository: git://github.com/rubyworks/ansi.git
  api: http://rubyworks.github.com/ansi/rdoc
  mail: http://groups.google.com/group/rubyworks-mailinglist
  home: http://rubyworks.github.com/ansi
  work: http://github.com/rubyworks/ansi
maintainers: []

requires: 
- group: 
  - build
  name: syckle
  version: 0+
- group: 
  - test
  name: ko
  version: 0+
manifest: MANIFEST
version: 1.2.5
licenses: 
- Apache 2.0
copyright: Copyright (c) 2009 Thomas Sawyer
authors: 
- Thomas Sawyer
- Florian Frank
organization: RubyWorks
description: The ANSI project is a collection of ANSI escape code related libraries enabling ANSI code based colorization and stylization of output. It is very nice for beautifying shell output.
summary: ANSI codes at your fingertips!
created: 2004-08-01
