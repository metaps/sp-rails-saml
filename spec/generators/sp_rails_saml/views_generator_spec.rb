RSpec.describe SpRailsSaml::ViewsGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "should create views" do
    assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
  end
end