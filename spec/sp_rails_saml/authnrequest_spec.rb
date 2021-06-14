RSpec.describe SpRailsSaml::Authnrequest do
  describe '#to_url' do
    let(:saml_setting) { OpenStruct.new(idp_sso_url: 'https://example.com', idp_entity_id: 'https://example.com', account: OpenStruct.new(id: 1)) }
    let(:sp_entity_id) { 'https://example.com' }
    let(:name_identifier_format) { 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress' }
    let(:authn_context) { 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509' }
    let(:authn_context_comparison) { 'exact' }
    let(:assertion_consumer_service_url) { 'https://example.com' }

    let!(:authnrequest) { SpRailsSaml::Authnrequest.new(saml_setting) }

    before do
      SpRailsSaml::Settings.class_variable_set(:@@setuped, false)

      allow(authnrequest).to receive(:saml_sso_url).and_return(assertion_consumer_service_url)
      allow(authnrequest).to receive(:saml_metadata_url).and_return(sp_entity_id)

      SpRailsSaml::Settings.setup do |config|
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.account_class = 'Account'
      end
    end

    it 'should create sso_url with saml request' do
      expect(authnrequest.to_url).to match(/^https:\/\/example\.com\?SAMLRequest=/)
    end

    it 'should create Authnrequest tag' do
      sso_url = authnrequest.to_url
      saml_request = CGI.unescape(sso_url.split("=").last)

      decoded_saml_request = Base64.decode64(saml_request)

      zstream  = Zlib::Inflate.new(-Zlib::MAX_WBITS)
      inflated = zstream.inflate(decoded_saml_request)
      zstream.finish
      zstream.close

      doc = REXML::Document.new(inflated)

      expect(doc.elements['samlp:AuthnRequest']['Destination']).to eq saml_setting.idp_sso_url
      expect(doc.elements['samlp:AuthnRequest']['AssertionConsumerServiceURL']).to eq assertion_consumer_service_url
    end

    it 'should create Issuer tag' do
      sso_url = authnrequest.to_url
      saml_request = CGI.unescape(sso_url.split("=").last)

      decoded_saml_request = Base64.decode64(saml_request)

      zstream  = Zlib::Inflate.new(-Zlib::MAX_WBITS)
      inflated = zstream.inflate(decoded_saml_request)
      zstream.finish
      zstream.close

      doc = REXML::Document.new(inflated)

      expect(doc.elements['samlp:AuthnRequest/saml:Issuer'].text.strip).to eq sp_entity_id
    end

    it 'should create RequestAuthnContext tag' do
      sso_url = authnrequest.to_url
      saml_request = CGI.unescape(sso_url.split("=").last)

      decoded_saml_request = Base64.decode64(saml_request)

      zstream  = Zlib::Inflate.new(-Zlib::MAX_WBITS)
      inflated = zstream.inflate(decoded_saml_request)
      zstream.finish
      zstream.close

      doc = REXML::Document.new(inflated)

      expect(doc.elements['samlp:AuthnRequest/samlp:RequestedAuthnContext']['Comparison']).to eq authn_context_comparison
      expect(doc.elements['samlp:AuthnRequest/samlp:RequestedAuthnContext/saml:AuthnContextClassRef'].text.strip).to eq authn_context
    end

    it 'should create NameIDPolicy tag' do
      sso_url = authnrequest.to_url
      saml_request = CGI.unescape(sso_url.split("=").last)

      decoded_saml_request = Base64.decode64(saml_request)

      zstream  = Zlib::Inflate.new(-Zlib::MAX_WBITS)
      inflated = zstream.inflate(decoded_saml_request)
      zstream.finish
      zstream.close

      doc = REXML::Document.new(inflated)

      expect(doc.elements['samlp:AuthnRequest/samlp:NameIDPolicy']['Format']).to eq name_identifier_format
    end
  end
end