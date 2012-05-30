# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "glyph_filter/version"

Gem::Specification.new do |s|
  s.name        = "glyph_filter"
  s.version     = GlyphFilter::VERSION
  s.authors     = ["Sean Cashin"]
  s.email       = ["scashin133@gmail.com"]
  s.homepage    = "https://github.com/socialcast/glyph_filter"
  s.summary     = %q{Filter glyphs in rails}
  s.description = %q{Add ability to filter ActiveRecord models by glyph and display a filter section in your views}

  s.rubyforge_project = "glyph_filter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "railties", ">= 3.0.0"
  s.add_dependency "wherex", "~> 1.0.7"
  s.add_development_dependency "capybara", ">= 0.4.0"
  s.add_development_dependency 'rspec', ['>= 0']
  s.add_development_dependency 'rspec-rails', ['>= 0']
  s.add_development_dependency 'database_cleaner', ['>= 0']
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rails", "~> 3.0"
  s.add_development_dependency "geminabox"
  s.add_development_dependency 'rr', ['>= 0']
  
end
