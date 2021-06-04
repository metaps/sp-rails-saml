RSpec.describe SpRailsSaml::SamlResponse do
  let(:saml_setting) { OpenStruct.new(idp_sso_url: 'https://example.com', idp_entity_id: 'https://example.com', account: OpenStruct.new(id: 1)) }
  let(:sp_entity_id) { 'https://example.com/sp' }
  let(:name_identifier_format) { 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress' }
  let(:authn_context) { 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509' }
  let(:authn_context_comparison) { 'exact' }
  let(:assertion_consumer_service_url) { 'https://example.com/acs' }

  let(:metadata) { SpRailsSaml::Metadata.new(account: saml_setting.account) }

  before do
    allow(metadata).to receive(:saml_sso_url).and_return(assertion_consumer_service_url)
    allow(metadata).to receive(:saml_metadata_url).and_return(sp_entity_id)

    SpRailsSaml::Settings.setup do |config|
      config.name_identifier_format = name_identifier_format
    end
  end

  describe '#metadata' do
    it 'should set entity_id' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor']['entityID']).to eq sp_entity_id
    end

    it 'should set AuthnRequestsSigned false' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor/md:SPSSODescriptor']['AuthnRequestsSigned']).to eq 'false'
    end

    it 'should set WantAssertionsSigned' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor/md:SPSSODescriptor']['WantAssertionsSigned']).to eq 'true'
    end

    it 'should set NameIdFormat' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor/md:SPSSODescriptor/md:NameIDFormat'].text.strip).to eq name_identifier_format
    end

    it 'should set AssertionConsumerService Binding' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor/md:SPSSODescriptor/md:AssertionConsumerService']['Binding']).to eq 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
    end

    it 'should set AssertionConsumerService Location' do
      doc = REXML::Document.new(metadata.generate)

      expect(doc.elements['md:EntityDescriptor/md:SPSSODescriptor/md:AssertionConsumerService']['Location']).to eq assertion_consumer_service_url
    end
  end
end