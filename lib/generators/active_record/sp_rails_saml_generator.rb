require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class SpRailsSamlGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def copy_migration
        migration_template "timestamp_create_saml_settings.rb", "db/migrate/timestamp_create_saml_settings"
      end
    end
  end
end
