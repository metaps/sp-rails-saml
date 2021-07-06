module Saml
  # Controller to register saml by SP
  class SamlSettingsBaseController < SamlBaseController
    # GET /saml/account_class/:#{account_class}_#{account_find_key}/saml_settings
    def show
      setting = SpRailsSaml::Settings.instance
      account = setting.account_class.find_by!(setting.account_find_key => params["#{setting.account_class.to_s.downcase}_#{setting.account_find_key}"])
      @saml_setting = account.saml_setting.present? ? account.saml_setting : account.build_smal_setting
    end

    # GET /saml/account_class/:#{account_class}_#{account_find_key}/saml_settings/edit
    def edit
      setting = SpRailsSaml::Settings.instance
      account = setting.account_class.find_by!(setting.account_find_key => params["#{setting.account_class.to_s.downcase}_#{setting.account_find_key}"])
      @saml_setting = account.saml_setting.present? ? account.saml_setting : account.build_smal_setting
    end

    # PATCH /saml/account_class/:#{account_class}_#{account_find_key}/saml_settings
    def update
      setting = SpRailsSaml::Settings.instance
      account = setting.account_class.find_by!(setting.account_find_key => params["#{setting.account_class.to_s.downcase}_#{setting.account_find_key}"])
      @saml_setting = account.saml_setting.present? ? account.saml_setting : account.build_smal_setting

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
