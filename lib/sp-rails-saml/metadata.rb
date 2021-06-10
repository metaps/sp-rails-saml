module SpRailsSaml
  class Metadata
    # url_forを使用するためにincludeしている
    # テスト時にエラーが発生するので定義されてない場合はスキップしたくdefined?(ActionView::Helpers)の場合のみinclude
    if defined?(ActionView::Helpers)
      include ActionView::Helpers
      include ActionDispatch::Routing
      include Rails.application.routes.url_helpers
    end

    def initialize(account:)
      @account = account
    end

    def generate
      metadata = OneLogin::RubySaml::Metadata.new
      metadata.generate(ruby_saml_settings)
    end

    private

    def required_value_is_set?
      SpRailsSaml::Settings.name_identifier_format
    end

    def ruby_saml_settings
      raise SettingValidationError, 'lack of required setting value' unless required_value_is_set?

      settings = OneLogin::RubySaml::Settings.new

      sp_rails_saml_setting = SpRailsSaml::Settings.instance

      settings.assertion_consumer_service_url     = saml_sso_url(@account.id)
      settings.sp_entity_id                       = saml_metadata_url(@account.id)
      settings.name_identifier_format             = sp_rails_saml_setting.name_identifier_format
      settings.security[:want_assertions_signed]  =
        SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:want_assertions_signed]
      settings
    end
  end
end
