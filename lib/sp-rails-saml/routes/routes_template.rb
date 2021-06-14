namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # Saml settings for SP
  get 'saml_settings', to: 'saml_settings#show'
  patch 'saml_settings', to: 'saml_settings#update'

  # SSO
  post 'sso/:id', to: 'ssos#consume', as: :sso
  get 'metadata/:id', to: 'ssos#metadata', as: :metadata
end
