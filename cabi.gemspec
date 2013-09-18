Gem::Specification.new do |s|
  s.name                  = 'cabi'
  s.version               = '0.1.3'
  s.summary               = "A simple, flat-file datastore for Ruby."
          
  s.description           = "Cabi is a flat-file datastore where data is stored by directory stucture and accessed by colon-delimited strings."
  s.authors               = ["Brian Gonzalez"]
  s.email                 = 'me@briangonzalez.org'
  s.homepage              = 'http://github.com/briangonzalez/cabi-gem'
  s.license               = 'MIT'
          
  s.files                 = Dir['[A-Z]*', 'cabi.gemspec', '{bin,lib,conf,web,data}/**/*'] - ['Gemfile.lock']
  s.executables           << 'cabi'

  s.add_dependency        "thor", "~> 0.18", ">= 0.18.1"

  s.required_ruby_version = '>= 1.9.3'
end