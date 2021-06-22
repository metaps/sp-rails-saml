$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'sp-rails-saml/version'

Gem::Specification.new do |spec|
  spec.name          = 'sp-rails-saml'
  spec.version       = SpRailsSaml::VERSION
  spec.authors       = ['psyashes', 'sibakeny']
  spec.email         = ['43512814+psyashes@users.noreply.github.com']

  spec.summary       = 'Simple sp saml for rails.'
  spec.description   = 'This gem is to be make onelogin ruby-saml easier to use in Ruby on Rails.'
  spec.homepage      = 'https://github.com/metaps/sp-rails-saml'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/metaps/sp-rails-saml'
  spec.metadata['changelog_uri'] = 'https://github.com/metaps/sp-rails-saml'

  spec.files         = Dir['{app,lib}/**/*', 'CHANGELOG.md', 'MIT-LICENSE', 'README.md']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('ruby-saml')
end
