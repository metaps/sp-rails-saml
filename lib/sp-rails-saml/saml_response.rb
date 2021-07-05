module SpRailsSaml
  # SAML2 Authentication Response.
  #
  class SamlResponse
    # url_forを使用するためにincludeしている
    # テスト時にエラーが発生するので定義されてない場合はスキップしたくdefined?(ActionView::Helpers)の場合のみinclude
    if defined?(ActionView::Helpers)
      include ActionView::Helpers
      include ActionDispatch::Routing
      include Rails.application.routes.url_helpers
    end

    def initialize(saml_response, saml_setting)
      @saml_setting = saml_setting
      @saml_response = saml_response
    end

    def response
      return @response if @response.present?

      @response = OneLogin::RubySaml::Response.new(
        @saml_response,
        settings: ruby_saml_settings,
        skip_subject_confirmation: SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:skip_subject_confirmation],
        skip_conditions: SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:skip_conditions],
        skip_destination: SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:skip_destination]
      )
    end

    def valid?
      response.is_valid?
    end

    def name_id
      response.name_id
    end

    def name_id_format
      response.name_id_format
    end

    def errors
      response.errors
    end

    private

    def required_value_is_set?
      # ruby-samlの仕様上、idp_entity_idが空だとissuer = idp_entity_idの検証が行われないため、idp_entity_idがblankの検証は必須
      @saml_setting.idp_cert.present? && @saml_setting.idp_entity_id.present?
    end

    def ruby_saml_settings
      raise SettingValidationError, 'lack of required setting value' unless required_value_is_set?

      settings = OneLogin::RubySaml::Settings.new

      sp_rails_saml_setting = SpRailsSaml::Settings.instance

      settings.assertion_consumer_service_url = saml_sp_consume_url(
        @saml_setting.send(sp_rails_saml_setting.account_class.to_s.downcase.to_sym).send(sp_rails_saml_setting.account_find_key)
      )
      settings.sp_entity_id = saml_sp_metadata_url(
        @saml_setting.send(sp_rails_saml_setting.account_class.to_s.downcase.to_sym).send(sp_rails_saml_setting.account_find_key)
      )
      settings.idp_cert                           = @saml_setting.idp_cert
      settings.idp_entity_id                      = @saml_setting.idp_entity_id
      settings.security[:want_assertions_signed]  =
        SpRailsSaml::Settings::RUBY_SAML_DEFAULT_SETTINGS[:want_assertions_signed]

      settings
    end
  end
end
