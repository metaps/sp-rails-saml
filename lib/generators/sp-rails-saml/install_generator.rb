require 'rails/generators'
require 'rails/generators/active_record'

module SpRailsSaml
  class InstallGenerator < ActiveRecord::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('templates', __dir__)

    desc 'Generate sp-rails-saml files.'

    class_option :settings, type: 'boolean', default: true

    def install_all
      generate "sp_rails_saml:views --settings #{options['settings']}"
      generate "sp_rails_saml:controllers --settings #{options['settings']}"
      generate "sp_rails_saml:model #{table_name}"
      generate 'sp_rails_saml:config'
    end

    private

    def default_initializer
      <<~RUBY
        Rails.configuration.to_prepare do
          SpRailsSaml::Settings.setup do |config|
            config.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
            config.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
            config.authn_context_comparison       = 'exact'
            config.user_class                     = User
            config.account_class                  = Account
          end
        end
      RUBY
    end
  end
end
