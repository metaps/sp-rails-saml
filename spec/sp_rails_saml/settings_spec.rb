RSpec.describe SpRailsSaml::Settings do
  describe '#setup' do
    let(:sp_entity_id) { 'sp_entity_id' }
    let(:name_identifier_format) { 'name_identifier_format' }
    let(:authn_context) { 'authn_context' }
    let(:authn_context_comparison) { 'authn_context_comparison' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }

    it 'should set settings value' do
      SpRailsSaml::Settings.setup do |config|
        config.sp_entity_id = sp_entity_id
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.assertion_consumer_service_url = assertion_consumer_service_url
      end

      expect(SpRailsSaml::Settings.sp_entity_id).to eq sp_entity_id
      expect(SpRailsSaml::Settings.name_identifier_format).to eq name_identifier_format
      expect(SpRailsSaml::Settings.authn_context).to eq authn_context
      expect(SpRailsSaml::Settings.authn_context_comparison).to eq authn_context_comparison
      expect(SpRailsSaml::Settings.assertion_consumer_service_url).to eq assertion_consumer_service_url
    end
  end
end
