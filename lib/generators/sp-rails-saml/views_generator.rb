require 'rails/generators'

module SpRailsSaml
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    desc 'Generate view files.'

    class_option :settings, type: 'boolean', default: true

    def create_session_view
      copy_file 'views/sessions/new.html.erb', 'app/views/saml/sessions/new.html.erb'
    end

    def create_saml_setting_view
      return unless options['settings']

      copy_file 'views/saml/edit.html.erb', 'app/views/saml/saml_settings/edit.html.erb'
      copy_file 'views/saml/show.html.erb', 'app/views/saml/saml_settings/show.html.erb'
    end
  end
end
