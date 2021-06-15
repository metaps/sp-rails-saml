module SpRailsSaml
  # Controller to register saml by SP
  #
  class SamlSettingsController < ApplicationController
    # GET /saml_settings
    #
    def show
      account = Account.find_by(id: params[:account_id])
      @saml_setting = account.saml_setting
    end

    # PATCH /saml_settings
    #
    def update
      account = Account.find_by(id: params[:account_id])
      @saml_setting = account.saml_setting

      if @saml_setting.update(saml_setting_params)
        redirect_to saml_setting_path
      else
        render :edit
      end
    end
  end
end
