namespace :saml do
  # Session
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # Saml settings for SP
  get 'saml_setting', to: 'saml_setting#show'
  get 'saml_setting', to: 'saml_setting#edit'
  patch 'saml_setting', to: 'saml_setting#edit'
end
