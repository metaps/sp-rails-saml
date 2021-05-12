require 'rails/generators'
require 'rails/generators/active_record'

module SpRailsSaml
  class ModelGenerator < ActiveRecord::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    def copy_migration
      p __FILE__
      migration_template "timestamp_create_saml_settings.rb", "db/migrate/timestamp_create_saml_settings.rb"
    end
  end
end
