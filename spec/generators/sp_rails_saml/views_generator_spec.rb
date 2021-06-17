RSpec.describe SpRailsSaml::ViewsGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  context 'without settings flag' do
    before do
      prepare_destination
      run_generator
    end

    it "should create views" do
      assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
      assert_file "app/views/saml/saml_settings/show.html.erb", file_fixture('views/saml/show.html.erb')
      assert_file "app/views/saml/saml_settings/edit.html.erb", file_fixture('views/saml/edit.html.erb')
    end
  end

  context 'when settings true' do
    before do
      prepare_destination
      run_generator %w(--settings true)
    end

    it "should create views" do
      assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
      assert_file "app/views/saml/saml_settings/show.html.erb", file_fixture('views/saml/show.html.erb')
      assert_file "app/views/saml/saml_settings/edit.html.erb", file_fixture('views/saml/edit.html.erb')
    end
  end

  context 'when settings false' do
    before do
      prepare_destination
      run_generator %w(--settings false)
    end

    it 'should no create saml_settings' do
      assert_file "app/views/saml/sessions/new.html.erb", file_fixture('views/sessions/new.html.erb')
      assert_no_file "app/views/saml/saml_settings/show.html.erb"
      assert_no_file "app/views/saml/saml_settings/edit.html.erb"
    end
  end
end
