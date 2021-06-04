RSpec.describe SpRailsSaml::Settings do
  class User; end
  class Account; end

  describe '#setup' do
    let(:sp_entity_id) { 'sp_entity_id' }
    let(:name_identifier_format) { 'name_identifier_format' }
    let(:authn_context) { 'authn_context' }
    let(:authn_context_comparison) { 'authn_context_comparison' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }
    let(:user_class) { User }
    let(:account_class) { Account }

    it 'should set settings value' do
      SpRailsSaml::Settings.setup do |config|
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.user_class = user_class
        config.account_class = account_class
      end

      expect(SpRailsSaml::Settings.name_identifier_format).to eq name_identifier_format
      expect(SpRailsSaml::Settings.authn_context).to eq authn_context
      expect(SpRailsSaml::Settings.authn_context_comparison).to eq authn_context_comparison
      expect(SpRailsSaml::Settings.user_class).to eq user_class
      expect(SpRailsSaml::Settings.account_class).to eq account_class
    end
  end
end
