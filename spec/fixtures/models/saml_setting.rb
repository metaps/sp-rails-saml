class SamlSetting < ApplicationRecord
  belongs_to :account

  enum login_type: { password_only: 0, saml_only: 1, saml_and_password: 2 }
end
