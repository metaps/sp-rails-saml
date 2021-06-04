require 'rails/generators'

module SpRailsSaml
  class ControllersGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    desc 'controller関係のファイルを自動生成します。'

    def create
      copy_file 'controllers/sessions_controller.rb', 'app/controllers/saml/sessions_controller.rb'
      copy_file 'controllers/ssos_controller.rb', 'app/controllers/saml/ssos_controller.rb'
    end
  end
end
