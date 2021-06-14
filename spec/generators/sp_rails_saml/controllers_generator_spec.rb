RSpec.describe SpRailsSaml::ControllersGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "should create saml_settings initializer file" do
    assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
    assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
  end

  it "should create saml_settings_controller in app/controllers/saml" do
    assert_file "app/controllers/saml/saml_settings_controller.rb", file_fixture('controllers/saml_settings_controller.rb')
  end
end
