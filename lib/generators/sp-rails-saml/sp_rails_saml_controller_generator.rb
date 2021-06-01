require 'rails/generators'

module SpRailsSaml
  # Controller file Generator.
  #
  class SpRailsSamlControllerGenerator < Rails::Generators::Base
    desc 'Generate sp_rails_saml_controller.rb to app/controllers'

    source_root File.expand_path('templates', __dir__)

    def create_controller_file
      create_file 'app/controllers/sp_rails_saml_controller.rb', 'sp_rails_saml_controller.rb'
    end
  end
end
