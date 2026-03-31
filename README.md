# ANSI

[HOME](https://rubyworks.github.io/ansi) &middot;
[API](https://rubydoc.info/gems/ansi) &middot;
[ISSUES](https://github.com/rubyworks/ansi/issues) &middot;
[SOURCE](https://github.com/rubyworks/ansi)

[![Gem Version](https://img.shields.io/gem/v/ansi.svg?style=flat)](https://rubygems.org/gems/ansi)
[![Build Status](https://github.com/rubyworks/ansi/actions/workflows/test.yml/badge.svg)](https://github.com/rubyworks/ansi/actions/workflows/test.yml)

<br/>

The ANSI project is a collection of ANSI escape code related libraries
enabling ANSI code based colorization and stylization of output.
It is very nice for beautifying shell output.

This collection is based on a set of scripts spun-off from
Ruby Facets. Included are Code (used to be ANSICode), Logger,
ProgressBar and String. In addition the library includes
Terminal which provides information about the current output
device.


## Features

* ANSI::Code provides ANSI codes as module functions.
* String#ansi makes common usage very easy and elegant.
* ANSI::Mixin provides an alternative mixin (like +colored+ gem).
* Very Good coverage of standard ANSI codes.
* Additional clases for colorized columns, tables, loggers and more.


## Synopsis

There are a number of modules and classes provided by the ANSI
package. To get a good understanding of them it is best to pursue 
the [QED documents](https://github.com/rubyworks/ansi/tree/master/demo/)
or the [API documentation](https://rubydoc.info/gems/ansi).

At the heart of all the provided libraries lies the ANSI::Code module
which defines ANSI codes as constants and methods. For example:

    require 'ansi/code'

    ANSI.red + "Hello" + ANSI.blue + "World"
    => "\e[31mHello\e[34mWorld"

Or in block form.

    ANSI.red{ "Hello" } + ANSI.blue{ "World" }
    => "\e[31mHello\e[0m\e[34mWorld\e[0m"

The methods defined by this module are used throughout the rest of
the system.


## Installation

### Bundler

Add the usual `gem` line to your project's `Gemfile`.

    gem 'ansi'

And run then `bundle` command.

### RubyGems

To install with RubyGems simply open a console and type:

    $ sudo gem install ansi

## Release Notes

Please see HISTORY.md file.


## License & Copyrights

Copyright (c) 2009 Rubyworks

This program is redistributable under the terms of the *BSD-2-Clause* license.

Some pieces of the code are copyrighted by others.

See LICENSE.txt and NOTICE.md files for details.

