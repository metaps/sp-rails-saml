RSpec.describe SpRailsSaml::SpRailsSamlControllerGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  let(:default_controller) do
    <<~RUBY
      module SpRailsSaml
        # Controller to register saml by SP
        #
        class SpRailsSamlController < ApplicationController
          # GET /saml_settings
          #
          def show
            account = Account.find_by(id: params[:account_id])
            @saml_setting = account.saml_setting
          end

          # GET /saml_settings/edit
          #
          def edit
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
    RUBY
  end

  it "should create sp_rails_saml_controller to app/controllers" do
    assert_file "app/controllers/sp_rails_saml_controller", default_controller
  end
end
