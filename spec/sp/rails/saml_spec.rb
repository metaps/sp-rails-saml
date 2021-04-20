RSpec.describe Sp::Rails::Saml do
  it "has a version number" do
    expect(Sp::Rails::Saml::VERSION).not_to be nil
  end

  it "return greeting message" do
    expect(Sp::Rails::Saml::Greet.say("Eren")).to eq("Eren, hello.")
  end
end
