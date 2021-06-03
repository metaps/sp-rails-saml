require 'rails/generators'

module SpRailsSaml
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    desc 'view関係のファイルを自動生成します。'

    def create
      copy_file 'views/sessions/new.html.erb', 'app/views/saml/sessions/new.html.erb'
    end
  end
end
