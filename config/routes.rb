Rails.application.routes.draw do
  root 'home#index'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, except: %i(index) do
    resources :stocks, controller: 'users/stocks',only: %i(index)
  end
  resources :items do
    resources :comments, only: %i(create)
    resource :stock, only: %i(create destroy)
  end
end
