namespace :saml do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  post 'sso/:id', to: 'ssos#consume', as: :sso
  get 'metadata/:id', to: 'ssos#metadata', as: :metadata
end
