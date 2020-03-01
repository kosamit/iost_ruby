lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "iost_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "iost_ruby"
  spec.version       = IostRuby::VERSION
  spec.authors       = ["kosamit"]
  spec.email         = ["kosamit@gmail.com"]

  spec.summary       = %q{IOST SDK for Ruby.}
  spec.description   = %q{IOST SDK for Ruby. This is development edition.}
  spec.homepage      = "https://github.com/kosamit/iost_ruby"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kosamit/iost_ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  spec.add_dependency 'ecdsa', '~> 1.1'
  spec.add_dependency 'faraday', '~> 0.17'
  spec.add_dependency 'faraday_middleware', '~> 0.14'
  spec.add_dependency 'json', '~> 2.3'
  spec.add_dependency 'base58', '~> 0.2.3'
  spec.add_dependency 'btcruby', '~> 1.8'
  spec.add_dependency 'ed25519', '~> 1.2', '>= 1.2.4'
  spec.add_dependency 'sha3', '~> 1.0', '>= 1.0.1'
  spec.add_dependency 'openssl', '~> 2.1', '>= 2.1.2'
  spec.add_dependency 'tweetnacl', '~> 1.0'
  spec.add_dependency 'digest-sha3'
  spec.add_dependency 'fast_jsonapi', '~> 1.5'
end
