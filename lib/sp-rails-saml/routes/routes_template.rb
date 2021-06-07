namespace :saml do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
end
