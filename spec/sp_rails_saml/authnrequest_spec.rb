RSpec.describe SpRailsSaml::Authnrequest do
  describe '#create' do
    let(:saml_setting) { OpenStruct.new(idp_sso_url: 'https://example.com', idp_entity_id: 'https://example.com') }
    let(:sp_entity_id) { 'https://example.com' }
    let(:name_identifier_format) { 'name_identifier_format' }
    let(:authn_context) { 'authn_context' }
    let(:authn_context_comparison) { 'authn_context_comparison' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }

    before do
      SpRailsSaml::Settings.setup do |config|
        config.sp_entity_id = sp_entity_id
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.assertion_consumer_service_url = assertion_consumer_service_url
      end
    end

    it 'should create sso_url with saml request' do
      sso_url = SpRailsSaml::Authnrequest.new(saml_setting).create
      expect(sso_url).to match(/^https:\/\/example\.com\?SAMLRequest=/)
    end

    it 'should create Authnrequest tag' do
      sso_url = SpRailsSaml::Authnrequest.new(saml_setting).create
      saml_request = sso_url.split("=").last

      decoded_saml_request = Base64.decode64(saml_request)
      doc = REXML::Document.new(decoded_saml_request)

      expect(doc.elements['samlp:AuthnRequest']['Version']).to eq '2.0'
      expect(doc.elements['samlp:AuthnRequest']['Destination']).to eq saml_setting.idp_sso_url
      expect(doc.elements['samlp:AuthnRequest']['AssertionConsumerServiceURL']).to eq assertion_consumer_service_url
    end

    it 'should create Issuer tag' do
      sso_url = SpRailsSaml::Authnrequest.new(saml_setting).create
      saml_request = sso_url.split("=").last

      decoded_saml_request = Base64.decode64(saml_request)
      doc = REXML::Document.new(decoded_saml_request)

      expect(doc.elements['samlp:AuthnRequest/Issuer'].text.strip).to eq sp_entity_id
    end

    it 'should create RequestAuthnContext tag' do
      sso_url = SpRailsSaml::Authnrequest.new(saml_setting).create
      saml_request = sso_url.split("=").last

      decoded_saml_request = Base64.decode64(saml_request)
      doc = REXML::Document.new(decoded_saml_request)

      expect(doc.elements['samlp:AuthnRequest/RequestedAuthnContext']['Comparison']).to eq authn_context_comparison
      expect(doc.elements['samlp:AuthnRequest/RequestedAuthnContext/AuthnContextClassRef'].text.strip).to eq authn_context
    end

    it 'should create NameIDPolicy tag' do
      sso_url = SpRailsSaml::Authnrequest.new(saml_setting).create
      saml_request = sso_url.split("=").last

      decoded_saml_request = Base64.decode64(saml_request)
      doc = REXML::Document.new(decoded_saml_request)

      expect(doc.elements['samlp:AuthnRequest/NameIDPolicy']['Format']).to eq name_identifier_format
    end
  end
end