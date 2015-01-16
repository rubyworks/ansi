#!/usr/bin/env ruby

ignore 'doc', 'site', 'log'

book :default => [:demo]

# Run QED demos
book :demo do
  desc "run demos"

  rule "demo/*.md"   => :run_demo
  rule "lib/**/*.rb" => :run_all

  def run_demo(*demos)
    shell "bundle exec qed -Ilib " + demos.join(' ')
  end

  def run_all
    shell "bundle exec qed -Ilib demo/*.md"
  end

  #task("demo") { shell "qed -Ilib qed/" }
end

# Run unit tests
book :test do
  desc "run unit tests"

  rule 'test/helper.rb'         => :test_all
  rule 'test/case_*.rb'         => :test
  rule /^lib\/(.*?)\.rb$/       => :test_match
  rule /^lib\/ansi\/(.*?)\.rb$/ => :test_match

  def test_all
    test *Dir['test/test_*.rb']
  end

  def test_match(m)
    test "test/case_#{m[1]}"
  end

  def test(*paths)
    shell "bundle exec rubytest #{gem_opt} -Ilib:test " + paths.flatten.join(' ')
  end

  def gem_opt
    defined?(::Gem) ? "-rubygems" : ""
  end

  #Signal.trap('QUIT') { test_all  } # Ctrl-\
end

#Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# Update .index file
book :index do
  desc "update index file"

  rule 'Index.yml' do
    shell "index -u Index.yml"
  end
end
