require 'rubygems/package_task'

gemspec = Gem::Specification.load('ansi.gemspec')

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Run QED demos"
task :demo do
  sh 'bundle exec qed'
end

desc "Run unit tests"
task :test do
  sh 'bundle exec ruby -Ilib -Itest -e "Dir.glob(\"test/case_*.rb\").each{|f| require \"./#{f}\"}"'
end

task :default => :demo
