# -*- encoding: utf-8 -*-
require File.expand_path('../lib/frothybeer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vidur Murali"]
  gem.email         = ["vidur.murali@gmail.com"]
  gem.description   = %q{Finds beers and their attributes from BeerAdvocate}
  gem.summary       = %q{Gets ratings, styles, abv content, breweries, and other information from a beer's name}
  gem.homepage      = "https://github.com/vyder/frothybeer"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "frothybeer"
  gem.require_paths = ["lib"]
  gem.version       = FrothyBeer::VERSION
  
  gem.add_runtime_dependency "bundler"
  gem.add_runtime_dependency "hpricot"
end