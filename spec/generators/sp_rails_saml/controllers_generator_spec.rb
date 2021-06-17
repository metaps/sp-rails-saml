RSpec.describe SpRailsSaml::ControllersGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  context 'without settings flag' do
    before do
      prepare_destination
      run_generator
    end

    it "should create saml sso controller file" do
      assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
      assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
    end
  
    it "should create saml_settings_controller in app/controllers/saml" do
      assert_file "app/controllers/saml/saml_settings_controller.rb", file_fixture('controllers/saml_settings_controller.rb')
    end
  end

  context 'when settings true' do
    before do
      prepare_destination
      run_generator %w(--settings true)
    end

    it "should create saml sso controller file" do
      assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
      assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
    end
  
    it "should create saml_settings_controller in app/controllers/saml" do
      assert_file "app/controllers/saml/saml_settings_controller.rb", file_fixture('controllers/saml_settings_controller.rb')
    end
  end

  context 'when settings false' do
    before do
      prepare_destination
      run_generator %w(--settings false)
    end

    it "should create saml sso controller file" do
      assert_file "app/controllers/saml/sessions_controller.rb", file_fixture('controllers/sessions_controller.rb')
      assert_file "app/controllers/saml/ssos_controller.rb", file_fixture('controllers/ssos_controller.rb')
    end
  
    it "should not create saml_settings_controller in app/controllers/saml" do
      assert_no_file "app/controllers/saml/saml_settings_controller.rb"
    end
  end
end
