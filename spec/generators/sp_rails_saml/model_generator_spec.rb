RSpec.describe SpRailsSaml::ModelGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)
  arguments %w[account]

  before(:all) do
    prepare_destination
    run_generator
  end

  let(:migration_text) do
    <<~RUBY
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
    RUBY
  end

  let(:model_text) do
    <<~RUBY
      class SamlSetting < ApplicationRecord
        belongs_to :account
      end
    RUBY
  end

  it 'should create saml_settings migration file' do
    assert_migration 'db/migrate/create_saml_settings', migration_text
  end

  it 'should create saml_settings model file' do
    assert_file 'app/models/saml_setting.rb', model_text
  end
end
