class CreateSamlSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :saml_settings, comment: 'Saml settings table for sp' do |t|
      t.references :<%= table_name.singularize %>, foreign_key: true, null: false, comment: 'For company account model'
      t.string :idp_sso_url, comment: 'URL for Idp SSO'
      t.text   :idp_cert, comment: 'X.509 Certification of Idp'
      t.string :idp_entity_id, comment: 'Entity ID of Idp'
      t.integer :login_type, limit: 1, default: 0, null: false
      t.timestamps
    end
  end
end
