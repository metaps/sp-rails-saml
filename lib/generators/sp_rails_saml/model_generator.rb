require 'rails/generators'
require 'rails/generators/active_record'

module SpRailsSaml
  class ModelGenerator < ActiveRecord::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    default_migration_file = <<-EOS
class CreateSamlSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :saml_settings, comment: 'Saml settings table for sp' do |t|
      t.references :account, foreign_key: true, null: false, comment: 'For company account model'
      t.string :idp_sso_url, comment: 'URL for Idp SSO'
      t.text   :idp_cert, comment: 'X.509 Certification of Idp'
      t.string :idp_entity_id, comment: 'Entity ID of Idp'
      t.timestamps
    end
  end
end
EOS

    # Overwrite default migration file for arguments
    File.write("./lib/generators/sp_rails_saml/templates/create_saml_settings.rb", default_migration_file)

    def copy_migration
      migration_template "create_saml_settings.rb", "db/migrate/create_saml_settings.rb"
    end
  end
end
