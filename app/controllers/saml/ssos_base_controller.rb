# frozen_string_literal: true

module Saml
  class SsosBaseController < SamlBaseController
    skip_forgery_protection only: %w[consume]

    # POST /saml/metadata/:id
    def consume
      setting = SpRailsSaml::Settings.instance
      account = setting.account_class.find_by(setting.account_find_key => params[setting.account_find_key])

      raise SpRailsSaml::SamlLoginForbidden if account.saml_setting.password_only?

      saml_setting = account.saml_setting
      saml_response = SpRailsSaml::SamlResponse.new(params[:SAMLResponse], saml_setting)

      raise SpRailsSaml::SamlResponseInvalid, saml_response.errors unless saml_response.valid?

      user = setting.user_class.find_by(setting.saml_response_user_find_key => saml_response.name_id)

      raise SpRailsSaml::LoginUserNotFound if user.blank?

      sign_in_with_saml(user)
    end

    # GET /saml/metadata/:id
    def metadata
      setting = SpRailsSaml::Settings.instance
      account = setting.account_class.find_by(setting.account_find_key => params[setting.account_find_key])
      metadata = SpRailsSaml::Metadata.new(account: account)
      render xml: metadata.generate
    end
  end
end
