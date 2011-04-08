watch( 'VERSION' ) do |md|
  system "sykle generate"
  system "pom spec > .ruby"
  system "pom gemspec -f"
end

