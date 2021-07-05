require 'pry'

class User; end

class Account; end

RSpec.describe SpRailsSaml::Settings do
  describe '#setup' do
    let(:sp_entity_id) { 'sp_entity_id' }
    let(:name_identifier_format) { 'name_identifier_format' }
    let(:authn_context) { 'authn_context' }
    let(:authn_context_comparison) { 'authn_context_comparison' }
    let(:assertion_consumer_service_url) { 'assertion_consumer_service_url' }
    let(:user_class) { User }
    let(:account_class) { Account }
    let(:user_find_key) { :label }
    let(:account_find_key) { :label }
    let(:saml_response_user_find_key) { :label }

    before do
      SpRailsSaml::Settings.class_variable_set(:@@setuped, false)
    end

    it 'should set settings value' do
      SpRailsSaml::Settings.setup do |config|
        config.name_identifier_format = name_identifier_format
        config.authn_context = authn_context
        config.authn_context_comparison = authn_context_comparison
        config.user_class = user_class
        config.account_class = account_class
        config.user_find_key = user_find_key
        config.account_find_key = account_find_key
        config.saml_response_user_find_key = saml_response_user_find_key
      end

      sp_rails_saml_setting = SpRailsSaml::Settings.instance

      expect(sp_rails_saml_setting.name_identifier_format).to eq name_identifier_format
      expect(sp_rails_saml_setting.authn_context).to eq authn_context
      expect(sp_rails_saml_setting.authn_context_comparison).to eq authn_context_comparison
      expect(sp_rails_saml_setting.user_class).to eq user_class
      expect(sp_rails_saml_setting.account_class).to eq account_class
      expect(sp_rails_saml_setting.user_find_key).to eq user_find_key
      expect(sp_rails_saml_setting.account_find_key).to eq account_find_key
      expect(sp_rails_saml_setting.saml_response_user_find_key).to eq saml_response_user_find_key
    end

    it 'raise if set setting value' do
      sp_rails_saml_setting = SpRailsSaml::Settings.instance
      expect { sp_rails_saml_setting.name_identifier_format = 'new_value' }.to raise_error(NoMethodError)
    end
  end
end
