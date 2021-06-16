require 'rails/generators'

module SpRailsSaml
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    desc 'Generate view files.'

    def create_session_view
      copy_file 'views/sessions/new.html.erb', 'app/views/saml/sessions/new.html.erb'
    end

    def create_saml_setting_view
      copy_file 'views/saml/new.html.erb', 'app/views/saml/new.html.erb'
    end
  end
end
