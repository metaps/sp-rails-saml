module SpRailsSaml
  class Authnrequest
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
      settings.assertion_consumer_service_url = SpRailsSaml::Settings.assertion_consumer_service_url
      settings.sp_entity_id                   = SpRailsSaml::Settings.sp_entity_id
      settings.name_identifier_format         = SpRailsSaml::Settings.name_identifier_format
      settings.authn_context                  = SpRailsSaml::Settings.authn_context
      settings.authn_context_comparison       = SpRailsSaml::Settings.authn_context_comparison
      settings.idp_entity_id                  = @saml_setting.idp_entity_id
      settings.idp_sso_service_url            = @saml_setting.idp_sso_url
      settings.compress_request               = false
      settings
    end
  end
end