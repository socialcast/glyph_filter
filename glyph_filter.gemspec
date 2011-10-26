# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "glyph_filter/version"

Gem::Specification.new do |s|
  s.name        = "glyph_filter"
  s.version     = GlyphFilter::VERSION
  s.authors     = ["Sean Cashin"]
  s.email       = ["scashin133@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Alphabetical filter for AR}
  s.description = %q{Alphabetical filter for AR}

  s.rubyforge_project = "glyph_filter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "railties", ">= 3.0.0"
end
