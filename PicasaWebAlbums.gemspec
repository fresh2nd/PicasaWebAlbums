# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "PicasaWebAlbums/version"

Gem::Specification.new do |s|
  s.name        = "PicasaWebAlbums"
  s.version     = PicasaWebAlbums::VERSION
  s.authors     = ["Martin Kraft"]
  s.email       = ["martinkraft@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Provides programmatic access to Picasa Web Albums data.}
  s.description = File.read(File.join(File.dirname(__FILE__), 'readme.md'))

  s.rubyforge_project = "PicasaWebAlbums"
  s.required_ruby_version = '>= 1.9.3'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
