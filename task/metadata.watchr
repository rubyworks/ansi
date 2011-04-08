watch 'VERSION' do |md|
  system "sykle generate"
  update_specs
end

watch 'PROFILE' do |md|
  update_specs 
end

def update_specs
  system "pom spec > .ruby"
  system "pom gemspec -f"
end

