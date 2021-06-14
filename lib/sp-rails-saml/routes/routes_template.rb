namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # Saml settings for SP
  get 'saml_settings', to: 'saml_settings#show'
  get 'saml_settings', to: 'saml_settings#edit'
  patch 'saml_settings', to: 'saml_settings#edit'

  # SSO
  post 'sso/:id', to: 'ssos#consume', as: :sso
  get 'metadata/:id', to: 'ssos#metadata', as: :metadata
end
