require 'singleton'

module SpRailsSaml
  # SAML2 settings for initializer.
  #
  class Settings
    include Singleton

    RUBY_SAML_DEFAULT_SETTINGS = {
      compress_request: true,
      skip_subject_confirmation: true,
      skip_conditions: true,
      skip_destination: false,
      want_assertions_signed: true,
      account_find_key: :id,
      user_find_key: :email,
      saml_response_user_find_key: :email
    }.freeze

    attr_reader :name_identifier_format,
                :authn_context,
                :authn_context_comparison,
                :user_class,
                :account_class,
                :user_find_key,
                :account_find_key,
                :saml_response_user_find_key

    class << self
      attr_accessor :name_identifier_format,
                    :authn_context,
                    :authn_context_comparison,
                    :user_class,
                    :account_class,
                    :user_find_key,
                    :account_find_key,
                    :saml_response_user_find_key

      def setup
        yield self

        setting = SpRailsSaml::Settings.instance

        setting.instance_variable_set(:@name_identifier_format, SpRailsSaml::Settings.name_identifier_format)
        setting.instance_variable_set(:@authn_context, SpRailsSaml::Settings.authn_context)
        setting.instance_variable_set(:@authn_context_comparison, SpRailsSaml::Settings.authn_context_comparison)
        setting.instance_variable_set(:@user_class, SpRailsSaml::Settings.user_class)
        setting.instance_variable_set(:@account_class, SpRailsSaml::Settings.account_class)
        setting.instance_variable_set(:@user_find_key, SpRailsSaml::Settings.user_find_key || RUBY_SAML_DEFAULT_SETTINGS[:user_find_key])
        setting.instance_variable_set(:@account_find_key, SpRailsSaml::Settings.account_find_key || RUBY_SAML_DEFAULT_SETTINGS[:account_find_key])
        setting.instance_variable_set(:@saml_response_user_find_key,
                                      SpRailsSaml::Settings.saml_response_user_find_key || RUBY_SAML_DEFAULT_SETTINGS[:saml_response_user_find_key])
      end
    end
  end
end
