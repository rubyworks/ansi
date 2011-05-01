# ANSI module contains all the ANSI related classes.
module ANSI
  #
  def self.meta
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/ansi.yml'))
    )
  end
  #
  def self.const_missing(name)
    meta[name.to_s.downcase] || super(name)
  end
end

require 'ansi/code'
require 'ansi/logger'
require 'ansi/progressbar'
require 'ansi/string'
require 'ansi/columns'
