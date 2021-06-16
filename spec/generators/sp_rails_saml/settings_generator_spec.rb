RSpec.describe SpRailsSaml::ConfigGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  let(:initializer_text) do
<<-EOS
SpRailsSaml::Settings.setup do |config|
  config.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
  config.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509'
  config.authn_context_comparison       = 'exact'
  config.user_class = User
  config.account_class = Account
end
EOS
  end

  it 'should create saml_settings initializer file' do
    assert_file 'config/initializers/sp-rails-saml.rb', initializer_text
  end
end
