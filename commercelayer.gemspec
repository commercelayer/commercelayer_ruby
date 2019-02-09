
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "commercelayer/version"

Gem::Specification.new do |spec|
  spec.name          = "commercelayer"
  spec.version       = Commercelayer::VERSION
  spec.authors       = ["Filippo Conforti"]
  spec.email         = ["filippo@commercelayer.io"]

  spec.summary       = "commercelayer"
  spec.description   = "The Official Commerce Layer Ruby Client"
  spec.homepage      = "https://github.com/commercelayer/commercelayer_ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'dotenv'

  spec.add_dependency "jsonapi-consumer", "~> 2.0.0.pre"
  spec.add_dependency "oauth2", "~> 1.4.0"
end
