require 'rails/generators'

module SpRailsSaml
  class ControllersGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    desc 'Generate controller files.'

    def create
      copy_file 'controllers/sessions_controller.rb', 'app/controllers/saml/sessions_controller.rb'
      copy_file 'controllers/sp_rails_saml_controller.rb', 'app/controllers/saml/sp_rails_saml_controller.rb'
    end
  end
end
