RSpec.describe SpRailsSaml::Setting do
  describe '#setup' do
    let(:sp_entity_id) { 'sp_entity_id' }
    let(:name_identifier_format) { 'name_identifier_format' }
    let(:authn_context) { 'authn_context' }
    let(:authn_context_comparison) { 'authn_context_comparison' }
    let(:idp_sso_service_url) { 'idp_sso_service_url' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }
    let(:idp_cert) { 'idp_cert' }
    let(:idp_entity_id) { 'idp_entity_id' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }

    it 'should set settings value' do
      SpRailsSaml::Setting.setup do |config|
        config.sp_entity_id = sp_entity_id
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.idp_sso_service_url = idp_sso_service_url
        config.assertion_consumer_service_url = assertion_consumer_service_url
        config.idp_cert = idp_cert
        config.idp_entity_id = idp_entity_id
        config.assertion_consumer_service_url = assertion_consumer_service_url
      end

      expect(SpRailsSaml::Setting.sp_entity_id).to eq sp_entity_id
      expect(SpRailsSaml::Setting.name_identifier_format).to eq name_identifier_format
      expect(SpRailsSaml::Setting.authn_context).to eq authn_context
      expect(SpRailsSaml::Setting.authn_context_comparison).to eq authn_context_comparison
      expect(SpRailsSaml::Setting.idp_sso_service_url).to eq idp_sso_service_url
      expect(SpRailsSaml::Setting.assertion_consumer_service_url).to eq assertion_consumer_service_url
      expect(SpRailsSaml::Setting.idp_cert).to eq idp_cert
      expect(SpRailsSaml::Setting.idp_entity_id).to eq idp_entity_id
      expect(SpRailsSaml::Setting.assertion_consumer_service_url).to eq assertion_consumer_service_url
    end
  end
end