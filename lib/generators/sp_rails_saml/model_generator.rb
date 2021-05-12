require 'rails/generators'
require 'rails/generators/active_record'

module SpRailsSaml
  class ModelGenerator < ActiveRecord::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    def copy_migration
      migration_template "create_saml_settings.rb", "db/migrate/create_saml_settings.rb"
    end
  end
end
