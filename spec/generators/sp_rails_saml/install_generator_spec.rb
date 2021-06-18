RSpec.describe SpRailsSaml::InstallGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  let(:migration_text) do
    <<~RUBY
      class CreateSamlSettings < ActiveRecord::Migration[6.1]
        def change
          create_table :saml_settings, comment: 'Saml settings table for sp' do |t|
            t.references :account, foreign_key: true, null: false, comment: 'For company account model'
            t.string :idp_sso_url, comment: 'URL for Idp SSO'
            t.text   :idp_cert, comment: 'X.509 Certification of Idp'
            t.string :idp_entity_id, comment: 'Entity ID of Idp'
            t.integer :login_type, limit: 1, default: 0, null: false
            t.timestamps
          end
        end
      end
    RUBY
  end

  let(:model_text) do
    <<~RUBY
      class SamlSetting < ApplicationRecord
        belongs_to :account

        enum login_type: { password_only: 0, saml_only: 1, saml_and_password: 2 }
      end
    RUBY
  end

  let(:initializer_text) do
    <<~RUBY
      SpRailsSaml::Settings.setup do |config|
        config.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
        config.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:X509'
        config.authn_context_comparison       = 'exact'
        config.user_class = User
        config.account_class = Account
      end
    RUBY
  end

  # TODO: generator_specのライブラリ側の問題だと思われるのですが、generate コマンドで生成されるファイルに関してテストだと生成されません。
  # 対応方法がわかり次第対応したいと思います。

  # context 'without settings flag' do
  #   before do
  #     prepare_destination
  #     run_generator %w(account)
  #   end

  #   it "should create saml sso controller file" do
  #     assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
  #     assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
  #   end

  #   it "should create saml_settings_controller in app/controllers/saml" do
  #     assert_file "app/controllers/saml/saml_settings_controller.rb", file_fixture('controllers/saml_settings_controller.rb')
  #   end

  #   it "should create saml_settings migration file" do
  #     assert_migration "db/migrate/create_saml_settings", migration_text
  #   end

  #   it "should create saml_settings model file" do
  #     assert_file "app/models/saml_setting.rb", model_text
  #   end

  #   it "should create views" do
  #     assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
  #     assert_file "app/views/saml/saml_settings/show.html.erb", file_fixture('views/saml/show.html.erb')
  #     assert_file "app/views/saml/saml_settings/edit.html.erb", file_fixture('views/saml/edit.html.erb')
  #   end

  #   it "should create saml_settings initializer file" do
  #     assert_file "config/initializers/sp-rails-saml.rb", initializer_text
  #   end
  # end

  # context 'when settings true' do
  #   before do
  #     prepare_destination
  #     run_generator %w(account --settings true)
  #   end

  #   it "should create saml sso controller file" do
  #     assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
  #     assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
  #   end

  #   it "should create saml_settings_controller in app/controllers/saml" do
  #     assert_file "app/controllers/saml/saml_settings_controller.rb", file_fixture('controllers/saml_settings_controller.rb')
  #   end

  #   it "should create saml_settings migration file" do
  #     assert_migration "db/migrate/create_saml_settings", migration_text
  #   end

  #   it "should create saml_settings model file" do
  #     assert_file "app/models/saml_setting.rb", model_text
  #   end

  #   it "should create views" do
  #     assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
  #     assert_file "app/views/saml/saml_settings/show.html.erb", file_fixture('views/saml/show.html.erb')
  #     assert_file "app/views/saml/saml_settings/edit.html.erb", file_fixture('views/saml/edit.html.erb')
  #   end

  #   it "should create saml_settings initializer file" do
  #     assert_file "config/initializers/sp-rails-saml.rb", initializer_text
  #   end
  # end

  # context 'when settings false' do
  #   before do
  #     prepare_destination
  #     run_generator %w(account --settings false)
  #   end

  #   it "should create saml sso controller file" do
  #     assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
  #     assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
  #   end

  #   it "should not create saml_settings_controller in app/controllers/saml" do
  #     assert_no_file "app/controllers/saml/saml_settings_controller.rb"
  #   end

  #   it "should create saml_settings migration file" do
  #     assert_migration "db/migrate/create_saml_settings", migration_text
  #   end

  #   it "should create saml_settings model file" do
  #     assert_file "app/models/saml_setting.rb", model_text
  #   end

  #   it 'should not create saml_settings' do
  #     assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
  #     assert_no_file "app/views/saml/saml_settings/show.html.erb"
  #     assert_no_file "app/views/saml/saml_settings/edit.html.erb"
  #   end

  #   it "should create saml_settings initializer file" do
  #     assert_file "config/initializers/sp-rails-saml.rb", initializer_text
  #   end
  # end
end
