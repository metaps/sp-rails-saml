require 'rails/generators'

module SpRailsSaml
  # Controller file Generator.
  #
  class SamlViewGenerator < Rails::Generators::Base
    desc 'Generate new.html.erb to app/views/saml'

    source_root File.expand_path('../templates', __dir__)

    def create_controller_file
      copy_file 'views/saml/new.html.erb', 'app/views/saml/new.html.erb'
    end
  end
end

