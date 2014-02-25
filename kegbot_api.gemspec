# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kegbot_api/version'

Gem::Specification.new do |spec|
  spec.name          = "kegbot_api"
  spec.version       = KegbotApi::VERSION
  spec.authors       = ["Eric Webb"]
  spec.email         = ["opensource@collectivegenius.net"]
  spec.summary       = "Kegbot REST API implementation in Ruby"
  spec.description   = "Kegbot REST API implementation in Ruby"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
      .reject { |path| path.match /\A\.idea\//  }     # Ignore .idea/ IntelliJ project directory
      .reject { |path| path.match /\A[^\/]+\.iml/ }   # Ignore *.iml IntelliJ module file
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "wwtd"
  spec.add_development_dependency "fakeweb", "~> 1.3"
  spec.add_development_dependency "yard", "0.8.7.3"
  spec.add_development_dependency "activesupport", "~> 4.0"
end
