require 'singleton'

# rubocop:disable Style/ClassVars
module SpRailsSaml
  # SAML2 settings for initializer.
  #
  class Settings
    include Singleton

    RUBY_SAML_DEFAULT_SETTINGS = {
      compress_request: true,
      skip_subject_confirmation: true,
      skip_conditions: true,
      want_assertions_signed: true
    }.freeze

    attr_reader :name_identifier_format,
                :authn_context,
                :authn_context_comparison,
                :user_class,
                :account_class

    @@setuped = false

    class << self
      attr_accessor :name_identifier_format,
                    :authn_context,
                    :authn_context_comparison,
                    :user_class,
                    :account_class

      def setup
        raise SpRailsSaml::MultiSetupError if @@setuped

        yield self

        setting = SpRailsSaml::Settings.instance

        setting.instance_variable_set(:@name_identifier_format, SpRailsSaml::Settings.name_identifier_format)
        setting.instance_variable_set(:@authn_context, SpRailsSaml::Settings.authn_context)
        setting.instance_variable_set(:@authn_context_comparison, SpRailsSaml::Settings.authn_context_comparison)
        setting.instance_variable_set(:@user_class, SpRailsSaml::Settings.user_class)
        setting.instance_variable_set(:@account_class, SpRailsSaml::Settings.account_class)

        @@setuped = true
      end
    end
  end
end
# rubocop:enable Style/ClassVars
