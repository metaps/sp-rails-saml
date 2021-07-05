Rails.configuration.to_prepare do
  SpRailsSaml::Settings.setup do |config|
    config.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
    config.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
    config.authn_context_comparison       = 'exact'
    config.user_class                     = User
    config.account_class                  = Account
  end
end
