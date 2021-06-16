RSpec.describe SpRailsSaml::ConfigGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'should create saml_settings initializer file' do
    assert_file 'config/initializers/sp-rails-saml.rb', file_fixture('initializers/sp-rails-saml.rb')
  end
end
