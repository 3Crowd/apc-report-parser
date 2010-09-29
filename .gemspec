Gem::Specification.new do |s|
  s.name	= "apc-report-parser"
  s.version	= "0.0.1"
  s.platform	= Gem::Platform::RUBY
  s.authors	= ["3Crowd Technologies, Inc.", "Justin Lynn"]
  s.email	= ["eng@3crowd.com"]
  s.homepage	= "http://github.com/3Crowd/apc-report-parser"
  s.summary	= "Parses APC HTML status output from apc.php"
  s.description = "Parses APC (Advanced PHP Cache) HTML status output from apc.php, included in a recent versions of PHP, into a data structure that is usable by ruby."

  s.add_dependency('choice', '>=0.1.4')
  s.add_dependency('nokogiri', '>=1.4.3.1')

  s.required_rubygems_version	= ">= 1.3.6"

  s.files	= Dir.glob("{bin,lib}/**/*") + %w(LICENSE README CHANGELOG)
  s.executables	= ['parse-apc-report']
  s.require_path = 'lib'
end
