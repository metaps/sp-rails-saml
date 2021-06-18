class CreateSamlSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :saml_settings, comment: 'Saml settings table for sp' do |t|
      t.references :account, foreign_key: true, null: false, comment: 'For company account model'
      t.string :idp_sso_url, comment: 'URL for Idp SSO'
      t.text   :idp_cert, comment: 'X.509 Certification of Idp'
      t.string :idp_entity_id, comment: 'Entity ID of Idp'
      t.integer :login_type, limit: 1, default: 0, null: false, comment: 'login_type(0: password_only, 1: saml_only, 2: password_and_saml)'
      t.timestamps
    end
  end
end
