# ANSI module contains all the ANSI related classes.
module ANSI
  # Returns Hash table of project metadata.
  def self.meta
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/ansi.yml'))
    )
  end

  # Check metadata for missing constants.
  def self.const_missing(name)
    meta[name.to_s.downcase] || super(name)
  end
end

require 'ansi/core'
require 'ansi/code'
require 'ansi/bbcode'
require 'ansi/columns'
require 'ansi/diff'
require 'ansi/logger'
require 'ansi/mixin'
require 'ansi/progressbar'
require 'ansi/string'
require 'ansi/table'
require 'ansi/terminal'

# Kernel method
def ansi(string, *codes)
  ANSI::Code.ansi(string, *codes)
end

