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
    create_table :saml_settings, comment: 'Saml settings table for sp' do |t|
      t.references :account, foreign_key: true, null: false, comment: 'For company account model'
      t.string :idp_sso_url, comment: 'URL for Idp SSO'
      t.text   :idp_cert, comment: 'X.509 Certification of Idp'
      t.string :idp_entity_id, comment: 'Entity ID of Idp'
      t.integer :login_type, limit: 1, default: 0, null: false
      t.timestamps
    end
  end
end
EOS
  end

  let(:model_text) do
<<-EOS
class SamlSetting < ApplicationRecord
  belongs_to :account

  enum login_type: { password_only: 0, saml_only: 1, saml_and_password: 2 }
end
EOS
  end

  it "should create saml_settings migration file" do
    assert_migration "db/migrate/create_saml_settings", migration_text
  end

  it "should create saml_settings model file" do
    assert_file "app/models/saml_setting.rb", model_text
  end
end
