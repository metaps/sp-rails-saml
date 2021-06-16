RSpec.describe SpRailsSaml::ModelGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)
  arguments %w[account]

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'should create saml_settings migration file' do
    assert_migration 'db/migrate/create_saml_settings', file_fixture('migrations/create_saml_settings.rb')
  end

  it 'should create saml_settings model file' do
    assert_file 'app/models/saml_setting.rb', file_fixture('models/saml_setting.rb')
  end
end
