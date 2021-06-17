# frozen_string_literal: true

module Saml
  class SessionsBaseController < SamlBaseController
    # GET /saml/sign_in
    def new; end

    # POST /saml/sign_in
    def create
      user = SpRailsSaml::Settings.user_class.find_by(email: params[:email])
      account = user.send(SpRailsSaml::Settings.account_class.to_s.downcase.to_sym)

      raise SamlLoginForbidden if account.saml_setting.password_only?

      if user.blank?
        redirect_to saml_sign_in_path, alert: 'failed to login'
        return
      end


      authnrequest = SpRailsSaml::Authnrequest.new(account.saml_setting).to_url
      redirect_to(authnrequest)
    end
  end
end
