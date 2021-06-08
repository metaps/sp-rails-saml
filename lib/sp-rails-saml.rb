require 'ruby-saml'
require 'sp-rails-saml/settings'
require 'sp-rails-saml/authnrequest'
require 'sp-rails-saml/saml_response'
require 'sp-rails-saml/draw_routes'
require 'generators/sp-rails-saml/config_generator'
require 'generators/sp-rails-saml/controllers_generator'
require 'generators/sp-rails-saml/views_generator'
require 'generators/sp-rails-saml/model_generator'
require 'generators/sp-rails-saml/sp_rails_saml_controller_generator'

autoload :SamlBaseController, File.expand_path('../app/controllers/saml_base_controller', __dir__)

module SpRailsSaml
  class Error < StandardError; end

  class SettingValidationError < Error; end
end

module Saml
  autoload :SessionsController, File.expand_path('../app/controllers/saml/sessions_controller', __dir__)
  autoload :SessionsBaseController, File.expand_path('../app/controllers/saml/sessions_base_controller', __dir__)
end
