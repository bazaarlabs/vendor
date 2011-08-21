# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vendor/version"

Gem::Specification.new do |s|
  s.name        = "vendor"
  s.version     = Vendor::VERSION
  s.authors     = ["Nathan Esquenazi"]
  s.email       = ["nesquena@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{iOS library management system}
  s.description = %q{iOS library management system}

  s.rubyforge_project = "vendor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'grit'
  s.add_dependency 'thor'
  s.add_dependency 'rb-appscript'
end
