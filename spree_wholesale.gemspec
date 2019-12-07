# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_wholesale/version"

Gem::Specification.new do |s|
  s.name        = "spree_wholesale"
  s.version     = SpreeWholesale::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Patrick McElwee, Spencer Steffen"]
  s.email       = ["patrick@sewliberated.com"]
  s.homepage    = "https://github.com/patrickmcelwee/spree_wholesale"
  s.summary     = %q{Wholesale accounts for Spree Commerce.}
  s.description = %q{Spree Wholesale adds a wholesale_price field to variants and allows users with a "wholesaler" role to access these prices.}

  s.files         = `git ls-files`.split("\n")
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]

  spree_version = '>= 3.1.0', '< 5.0'
  s.add_runtime_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_frontend', spree_version
  s.add_dependency 'spree_api', spree_version
  s.add_runtime_dependency 'spree_auth_devise', spree_version
  s.add_runtime_dependency 'spree_extension'

  s.add_development_dependency('spree_sample', spree_version)
  # s.add_development_dependency('shoulda')
  s.add_development_dependency('factory_bot')
  s.add_development_dependency('capybara')
  s.add_development_dependency('launchy')
  s.add_development_dependency('sass-rails')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency 'rspec-rails', '4.0.0.beta3'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'jsonapi-rspec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers', '3.1.3'
end
