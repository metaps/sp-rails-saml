namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  unless @sso_only
    # Saml settings for SP
    resources SpRailsSaml::Settings.account_class.to_s.downcase.to_sym, only: [] do
      resource :saml_settings, only: %i[show edit update]
    end
  end

  # SSO
  post 'sso/:id', to: 'ssos#consume', as: :sso
  get 'metadata/:id', to: 'ssos#metadata', as: :metadata
end
