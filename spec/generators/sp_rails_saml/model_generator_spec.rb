RSpec.describe SpRailsSaml::ModelGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)
  arguments %w(account)

  before(:all) do
    prepare_destination
    run_generator
  end

  let(:migration_text) do
<<-EOS
class CreateSamlSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :saml_settings do |t|
      t.references :account, foreign_key: true, null: false
      t.string :idp_sso_url
      t.text   :idp_cert
      t.string :idp_entity_id
      t.timestamps
    end
  end
end
EOS
  end

  it "should create saml_settings migration file" do
    assert_migration "db/migrate/create_saml_settings", migration_text
  end
end
