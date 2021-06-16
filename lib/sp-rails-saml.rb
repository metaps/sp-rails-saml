require 'ruby-saml'
require 'sp-rails-saml/settings'
require 'sp-rails-saml/draw_routes'
require 'generators/sp-rails-saml/config_generator'
require 'generators/sp-rails-saml/controllers_generator'
require 'generators/sp-rails-saml/views_generator'
require 'generators/sp-rails-saml/model_generator'

autoload :SamlBaseController, File.expand_path('../app/controllers/saml_base_controller', __dir__)

module SpRailsSaml
  class Error < StandardError; end

  class SettingValidationError < Error; end

  class MultiSetupError < Error; end

  autoload :Authnrequest, File.expand_path('./sp-rails-saml/authnrequest', __dir__)
  autoload :SamlResponse, File.expand_path('./sp-rails-saml/saml_response', __dir__)
  autoload :Metadata, File.expand_path('./sp-rails-saml/metadata', __dir__)
end

module Saml
  autoload :SessionsController, File.expand_path('../app/controllers/saml/sessions_controller', __dir__)
  autoload :SessionsBaseController, File.expand_path('../app/controllers/saml/sessions_base_controller', __dir__)
  autoload :SamlSettingsController, File.expand_path('../app/controllers/saml/saml_settings_controller', __dir__)
  autoload :SsosController, File.expand_path('../app/controllers/saml/ssos_controller', __dir__)
  autoload :SsosBaseController, File.expand_path('../app/controllers/saml/ssos_base_controller', __dir__)
end
