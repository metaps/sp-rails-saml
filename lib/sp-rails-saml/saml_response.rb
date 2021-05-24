module SpRailsSaml
  class SamlResponse
    def initialize(saml_response, saml_setting)
      @saml_setting = saml_setting
      @response = OneLogin::RubySaml::Response.new(
        saml_response,
        settings: ruby_saml_settings,
        skip_subject_confirmation: SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:skip_subject_confirmation],
        skip_conditions: SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:skip_conditions]
      )
    end

    def valid?
      @response.is_valid?
    end

    def name_id
      @response.name_id
    end

    def name_id_format
      @response.name_id_format
    end

    def errors
      @response.errors
    end

    private

    def required_value_is_set?
      SpRailsSaml::Settings.assertion_consumer_service_url.present? &&
        SpRailsSaml::Settings.sp_entity_id.present? &&
        @saml_setting.idp_cert.present?
    end

    def ruby_saml_settings
      raise SettingValidationError, 'lack of required setting value' unless required_value_is_set?

      settings = OneLogin::RubySaml::Settings.new
      settings.assertion_consumer_service_url = SpRailsSaml::Settings.assertion_consumer_service_url
      settings.sp_entity_id                   = SpRailsSaml::Settings.sp_entity_id
      settings.idp_cert                       = @saml_setting.idp_cert
      settings
    end
  end
end