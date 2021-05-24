RSpec.describe SpRailsSaml::SamlResponse do
  let!(:saml_response_base64_str) { file_fixture("saml_response.xml.base64") }
  let(:sp_entity_id) { 'https://example.com/sp' }
  let(:name_identifier_format) { 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress' }
  let(:authn_context) { 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509' }
  let(:authn_context_comparison) { 'exact' }
  let(:assertion_consumer_service_url) { 'https://example.com/acs' }

  before do
    SpRailsSaml::Settings.setup do |config|
      config.sp_entity_id = sp_entity_id
      config.name_identifier_format = name_identifier_format
      config.authn_context = authn_context
      config.authn_context_comparison = authn_context_comparison
      config.assertion_consumer_service_url = assertion_consumer_service_url
    end
  end

  describe '#valid?' do
    let(:saml_setting) {
      OpenStruct.new(
        idp_entity_id: 'http://localhost:3000/saml/metadata/kti85Q2miJBbOnvxBIEgYA',
        idp_cert: file_fixture('certificate')
      )
    }

    context 'when valid saml response' do
      it 'should return true' do
        saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)

        expect(saml_response.valid?).to be_truthy
      end
    end

    context 'when sp_entity_id is not equal issuer' do
      before do
        SpRailsSaml::Settings.setup({sp_entity_id: 'dummy'})
      end

      it 'should return false' do
        saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
        expect(saml_response.valid?).to be_falsey
      end
    end

    context 'when certificate is not valid' do
      before do
        saml_setting.idp_cert = file_fixture('wrong_certificate')
      end

      it 'should return false' do
        saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
        expect(saml_response.valid?).to be_falsey
      end
    end

    context 'when assertion_consumer_service_url is not equal Destination' do
      before do
        SpRailsSaml::Settings.setup({assertion_consumer_service_url: 'dummy'})
      end

      it 'should return false' do
        saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
        expect(saml_response.valid?).to be_falsey
      end
    end

    context 'lack of setting value' do
      before do
        SpRailsSaml::Settings.setup({assertion_consumer_service_url: nil})
      end

      it 'should return SettingValidationError' do
        expect { SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting) }.to raise_error(SpRailsSaml::SettingValidationError)
      end
    end
  end

  describe '#name_id' do
    let(:saml_setting) {
      OpenStruct.new(
        idp_entity_id: 'http://localhost:3000/saml/metadata/kti85Q2miJBbOnvxBIEgYA',
        idp_cert: file_fixture('certificate')
      )
    }

    it 'should return name_id' do
      saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
      expect(saml_response.name_id).to eq 'test@example.com'
    end
  end

  describe '#name_identifier_format' do
    let(:saml_setting) {
      OpenStruct.new(
        idp_entity_id: 'http://localhost:3000/saml/metadata/kti85Q2miJBbOnvxBIEgYA',
        idp_cert: file_fixture('certificate')
      )
    }

    it 'should return name_identifier_format' do
      saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
      expect(saml_response.name_id_format).to eq name_identifier_format
    end
  end

  describe "#errors" do
    let(:saml_setting) {
      OpenStruct.new(
        idp_entity_id: 'http://localhost:3000/saml/metadata/kti85Q2miJBbOnvxBIEgYA',
        idp_cert: file_fixture('certificate')
      )
    }

    context 'when sp_entity_id is not equal issuer' do
      before do
        SpRailsSaml::Settings.setup({sp_entity_id: 'dummy'})
      end

      # エラーに関してはruby-samlの内容をそのまま渡しているだけなので、エラーが返ってくることのみ検証して、それぞれの設定値に対するエラー内容の検証は行いません。
      it 'should return error messages' do
        saml_response = SpRailsSaml::SamlResponse.new(saml_response_base64_str, saml_setting)
        saml_response.valid?

        expect(saml_response.errors).to eq ['Invalid Audience. The audience https://example.com/sp, did not match the expected audience dummy']
      end
    end
  end
end