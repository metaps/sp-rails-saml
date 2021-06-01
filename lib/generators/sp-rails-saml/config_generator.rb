require 'rails/generators'

module SpRailsSaml
  # Initializer file Generator.
  #
  class ConfigGenerator < Rails::Generators::Base
    desc 'Generate sp-rails-saml.rb to config/initializers'

    def create_initializer_file
      create_file 'config/initializers/sp-rails-saml.rb', default_initializer
    end

    private

    def default_initializer
      <<~RUBY
        SpRailsSaml::Settings.setup do |config|
          config.sp_entity_id                   = ''
          config.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
          config.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509'
          config.authn_context_comparison       = 'exact'
          config.assertion_consumer_service_url = ''
        end
      RUBY
    end
  end
end
