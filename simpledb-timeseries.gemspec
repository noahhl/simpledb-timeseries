Gem::Specification.new do |s|
  s.name        = "simpledb-timeseries"
  s.version     = "0.0.0"
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Implementation of antirez's redis-timeseries using aws simpledb as a datastore" 
  s.require_paths = ["lib"]
  s.files = Dir["#{File.dirname(__FILE__)}/*/**"]

  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_dependency 'aws-sdb'

end

