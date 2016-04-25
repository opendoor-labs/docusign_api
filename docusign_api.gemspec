Gem::Specification.new do |gem|
  gem.name        = 'docusign_api'
  gem.version     = '0.1.0'
  gem.date        = '2016-04-25'
  gem.summary     = "A ruby gem for using the DocuSign REST API with libcurl"
  gem.description = "A ruby gem for using the DocuSign REST API with libcurl"
  gem.authors     = ["Open Listings Engineering"]
  gem.email       = 'engineering@openlistings.com'
  gem.homepage    = 'https://github.com/openlistings/docusign-api-rest-libcurl'
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'capistrano', '~> 3.1'
  gem.add_dependency 'sshkit', '~> 1.2'
  gem.add_dependency 'curb', '< 0.9'

  gem.add_development_dependency 'minitest', '~> 5.8'
  gem.add_development_dependency 'mocha', '~> 1.1'
  gem.add_development_dependency 'webmock', '1.22.3'
end
