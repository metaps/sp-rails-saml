require 'rails/generators'

module SpRailsSaml
  # Controller file Generator.
  #
  class SpRailsSamlControllerGenerator < Rails::Generators::Base
    desc 'Generate sp_rails_saml_controller.rb to app/controllers'

    source_root File.expand_path('templates', __dir__)

    def create_controller_file
      create_file 'app/controllers/sp_rails_saml_controller.rb', <<~RUBY
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
  end
end
