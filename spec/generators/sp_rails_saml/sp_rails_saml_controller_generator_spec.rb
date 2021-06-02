RSpec.describe SpRailsSaml::SpRailsSamlControllerGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "should create sp_rails_saml_controller to app/controllers" do
    assert_file "app/controllers/sp_rails_saml_controller.rb", file_fixture('controllers/sp_rails_saml_controller.rb')
  end
end
