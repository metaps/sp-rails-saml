require 'rails/generators'
require 'rails/generators/active_record'

module SpRailsSaml
  class ModelGenerator < ActiveRecord::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('templates', __dir__)

    def create_initializer_file
      migration_template 'create_saml_settings.rb', 'db/migrate/create_saml_settings.rb'
    end

    def copy_model
      create_file 'app/models/saml_setting.rb', <<~FILE
        class SamlSetting < ApplicationRecord
          belongs_to :#{table_name.singularize}
        end
      FILE
    end
  end
end
