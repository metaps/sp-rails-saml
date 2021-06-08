RSpec.describe SpRailsSaml::ControllersGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "should create saml_settings initializer file" do
    assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
    assert_file "app/controllers/saml/sp_rails_saml_controller.rb", file_fixture('controllers/sp_rails_saml_controller.rb')
  end
end
