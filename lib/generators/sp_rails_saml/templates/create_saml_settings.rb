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
