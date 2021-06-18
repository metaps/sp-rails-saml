require 'rails/generators'

module SpRailsSaml
  class ControllersGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc 'Generate controller files.'

    class_option :settings, type: 'boolean', default: true

    def create_session_controller
      copy_file 'controllers/sessions_controller.rb', 'app/controllers/saml/sessions_controller.rb'
      copy_file 'controllers/ssos_controller.rb', 'app/controllers/saml/ssos_controller.rb'
    end

    def create_saml_setting_controller
      copy_file 'controllers/saml_settings_controller.rb', 'app/controllers/saml/saml_settings_controller.rb' if options['settings']
    end
  end
end
