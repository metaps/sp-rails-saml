require 'ruby-saml'
require 'sp-rails-saml/settings'
require 'sp-rails-saml/authnrequest'
require 'sp-rails-saml/saml_response'
require 'generators/sp-rails-saml/config_generator'

module SpRailsSaml
  class Error < StandardError; end

  class SettingValidationError < Error; end
end
