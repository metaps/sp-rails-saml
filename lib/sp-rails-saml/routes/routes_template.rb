namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # Saml settings for SP
  resources SpRailsSaml::Settings.account_class.to_s.downcase.to_sym, only: [] do
    resource :saml_settings, only: [:show, :edit, :update]
  end

  # SSO
  post 'sso/:id', to: 'ssos#consume', as: :sso
  get 'metadata/:id', to: 'ssos#metadata', as: :metadata
end
