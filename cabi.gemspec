Gem::Specification.new do |s|
  s.name                  = 'cabi'
  s.version               = '0.1.0'
  s.date                  = '2013-09-16'
  s.summary               = "A simple, flat-file datastore for static content."
          
  s.description           = "Cabi is a flat-file datastore where data is stored by directory stucture and accessed by colon-delimited strings."
  s.authors               = ["Brian Gonzalez"]
  s.email                 = 'me@briangonzalez.org'
  s.homepage              = 'http://github.com/briangonzalez/cabi-gem'
  s.license               = 'MIT'
          
  s.files                 = Dir['[A-Z]*', 'cabi.gemspec', '{bin,lib,conf,web}/**/*'] - ['Gemfile.lock']
  s.executables           << 'cabi'
  s.require_path          = 'lib'

  s.required_ruby_version = '>= 1.9.3'
end