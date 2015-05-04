# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'knife-tagbatch/version'

Gem::Specification.new do |gem|
  gem.name          = "knife-tagbatch"
  gem.version       = CustomChef::KnifeTagBatch::VERSION
  gem.authors       = ["Nikolas Karavias"]
  gem.email         = ["nikolas.karavias@oracle.com"]
  gem.licenses = ["GPL-3"]
  gem.summary       = %q{Add search functionality to the knife tag command}
  gem.description   = gem.summary
  gem.homepage      = "https://github.com/nkaravias/knife-tagbatch"
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "chef"
end
