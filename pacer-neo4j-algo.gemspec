# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pacer-neo4j-algo/version"

Gem::Specification.new do |s|
  s.name        = "pacer-neo4j-algo"
  s.version     = Pacer::Neo4j::Algo::VERSION
  s.platform    = 'java'
  s.authors     = ["Darrick Wiebe"]
  s.email       = ["dw@xnlogic.com"]
  s.homepage    = ""
  s.summary     = %q{Neo4J-specific algorithms and features integrated into Pacer}
  s.description = %q{}

  s.rubyforge_project = "pacer-neo4j-algo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "awesome_print"

  s.add_dependency "pacer-neo4j", Pacer::Neo4j::Algo::PACER_NEO4J_VERSION
  s.add_dependency "neo4j",       Pacer::Neo4j::Algo::NEO4J_VERSION
end
