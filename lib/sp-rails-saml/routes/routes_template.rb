namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  unless @sso_only
    # Saml settings for SP
    resources SpRailsSaml::Settings.instance.account_class.to_s.downcase.to_sym, only: [], param => SpRailsSaml::Settings.instance.account_find_key do
      resource :saml_settings, only: %i[show edit update]
    end
  end

  # SSO
  post "sp/consume/:#{SpRailsSaml::Settings.instance.account_find_key}", to: 'ssos#consume', as: :sp_consume
  get "sp/metadata/:#{SpRailsSaml::Settings.instance.account_find_key}", to: 'ssos#metadata', as: :sp_metadata
end
