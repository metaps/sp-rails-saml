module SpRailsSaml
  # SAML2 Authentication.
  #
  class Authnrequest
    # url_forを使用するためにincludeしている
    # テスト時にエラーが発生するので定義されてない場合はスキップしたくdefined?(ActionView::Helpers)の場合のみinclude
    if defined?(ActionView::Helpers)
      include ActionView::Helpers
      include ActionDispatch::Routing
      include Rails.application.routes.url_helpers
    end

    def initialize(saml_setting)
      @saml_setting = saml_setting
    end

    def to_url
      request = OneLogin::RubySaml::Authrequest.new
      request.create(ruby_saml_settings)
    end

    private

    def ruby_saml_settings
      settings = OneLogin::RubySaml::Settings.new

      sp_rails_saml_setting = SpRailsSaml::Settings.instance

      settings.assertion_consumer_service_url = saml_sp_consume_url(
        @saml_setting.send(sp_rails_saml_setting.account_class.to_s.downcase.to_sym).send(sp_rails_saml_setting.account_find_key)
      )
      settings.sp_entity_id = saml_sp_metadata_url(
        @saml_setting.send(sp_rails_saml_setting.account_class.to_s.downcase.to_sym).send(sp_rails_saml_setting.account_find_key)
      )
      settings.name_identifier_format         = sp_rails_saml_setting.name_identifier_format
      settings.authn_context                  = sp_rails_saml_setting.authn_context
      settings.authn_context_comparison       = sp_rails_saml_setting.authn_context_comparison
      settings.idp_entity_id                  = @saml_setting.idp_entity_id
      settings.idp_sso_service_url            = @saml_setting.idp_sso_url
      settings.compress_request               = SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:compress_request]
      settings
    end
  end
end
