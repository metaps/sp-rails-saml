module Saml
  # Controller to register saml by SP
  class SamlSettingsBaseController < SamlBaseController
    # GET /saml/SpRailsSaml::Settings.account_class.to_s.downcase/:#{SpRailsSaml::Settings.account_class.to_s.downcase}_id/saml_settings
    def show
      account = SpRailsSaml::Settings.account_class.find_by(id: params["#{SpRailsSaml::Settings.account_class.to_s.downcase}_id"])
      @saml_setting = SamlSetting.find_or_initialize_by("#{SpRailsSaml::Settings.account_class.to_s.downcase}_id" => account.id)
    end

    # GET /saml/SpRailsSaml::Settings.account_class.to_s.downcase/:#{SpRailsSaml::Settings.account_class.to_s.downcase}_id/saml_settings/edit
    def edit
      account = SpRailsSaml::Settings.account_class.find_by(id: params["#{SpRailsSaml::Settings.account_class.to_s.downcase}_id"])
      @saml_setting = SamlSetting.find_or_initialize_by("#{SpRailsSaml::Settings.account_class.to_s.downcase}_id" => account.id)
    end

    # PATCH /saml/SpRailsSaml::Settings.account_class.to_s.downcase/:#{SpRailsSaml::Settings.account_class.to_s.downcase}_id/saml_settings
    def update
      account = SpRailsSaml::Settings.account_class.find_by(id: params["#{SpRailsSaml::Settings.account_class.to_s.downcase}_id"])
      @saml_setting = SamlSetting.find_or_initialize_by("#{SpRailsSaml::Settings.account_class.to_s.downcase}_id" => account.id)

      @saml_setting.assign_attributes(saml_setting_params)

      if @saml_setting.save
        redirect_to action: :show
      else
        render :edit
      end
    end

    private

    def saml_setting_params
      params.require(:saml_setting).permit(:idp_entity_id, :idp_sso_url, :idp_cert, :login_type)
    end
  end
end
