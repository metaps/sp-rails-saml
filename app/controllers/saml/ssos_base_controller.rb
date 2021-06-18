# frozen_string_literal: true

module Saml
  class SsosBaseController < SamlBaseController
    skip_forgery_protection only: %w[consume]

    # POST /saml/metadata/:id
    def consume
      account = SpRailsSaml::Settings.account_class.find(params[:id])

      raise SpRailsSaml::SamlLoginForbidden if account.saml_setting.password_only?

      saml_setting = account.saml_setting
      saml_response = SpRailsSaml::SamlResponse.new(params[:SAMLResponse], saml_setting)

      if saml_response.valid?
        user = SpRailsSaml::Settings.user_class.find_by(email: saml_response.name_id)
        raise LoginUserNotFound if user.blank?

        sign_in_with_saml(user)
      else
        redirect_to saml_sign_in_path, alert: 'failed to login'
      end
    end

    # GET /saml/metadata/:id
    def metadata
      account = SpRailsSaml::Settings.account_class.find(params[:id])
      metadata = SpRailsSaml::Metadata.new(account: account)
      render xml: metadata.generate
    end
  end
end
