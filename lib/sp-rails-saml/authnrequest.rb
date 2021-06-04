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

      settings.assertion_consumer_service_url = saml_sso_url(id: @saml_setting.send(SpRailsSaml::Settings.account_class.to_s.downcase.to_sym).id)
      settings.sp_entity_id                   = saml_metadata_url(id: @saml_setting.send(SpRailsSaml::Settings.account_class.to_s.downcase.to_sym).id)
      settings.name_identifier_format         = SpRailsSaml::Settings.name_identifier_format
      settings.authn_context                  = SpRailsSaml::Settings.authn_context
      settings.authn_context_comparison       = SpRailsSaml::Settings.authn_context_comparison
      settings.idp_entity_id                  = @saml_setting.idp_entity_id
      settings.idp_sso_service_url            = @saml_setting.idp_sso_url
      settings.compress_request               = SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:compress_request]
      settings
    end
  end
end
