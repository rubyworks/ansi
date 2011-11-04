# ANSI module contains all the ANSI related classes.
module ANSI
  # Returns Hash table of project metadata.
  def self.meta
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/../ansi.yml'))
    )
  end

  # Check metadata for missing constants.
  def self.const_missing(name)
    meta[name.to_s.downcase] || super(name)
  end
end

