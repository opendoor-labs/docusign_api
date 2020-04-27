Gem::Specification.new do |gem|
  gem.name        = 'docusign_api'
  gem.version     = '0.1.2'
  gem.date        = '2019-04-27'
  gem.summary     = "Use the DocuSign REST API with libcurl"
  gem.description = "A ruby gem for using the DocuSign REST API with libcurl"
  gem.authors     = ["Alex Farrill"]
  gem.email       = ['alex.farrill@opendoor.com']
  gem.homepage    = 'https://github.com/opendoor-labs/docusign_api'
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'curb', '< 1.0'

  gem.add_development_dependency 'minitest', '~> 5.8'
  gem.add_development_dependency 'mocha', '~> 1.1'
  gem.add_development_dependency 'webmock', '~> 3.8'
  gem.add_development_dependency 'rake', '~> 12.3'
end
