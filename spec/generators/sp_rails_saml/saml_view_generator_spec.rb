RSpec.describe SpRailsSaml::SamlViewGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "should create saml setting view file to app/views/saml" do
    assert_file "app/views/saml/new.html.erb", file_fixture('views/saml/new.html.erb')
  end
end
