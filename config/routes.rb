Rails.application.routes.draw do
  root 'home#index'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, except: %i(index) do
    resources :stocks, controller: 'users/stocks', only: %i(index)
    resources :items, controller: 'users/items', only: %i(index)
    resource :follow_user, controller: 'users/follow_users', only: %i(create destroy) do
      collection do
        get 'followers'
        get 'following'
      end
    end
  end
  resources :items do
    resources :comments, controller: 'items/comments', only: %i(create)
    resource :stock, controller: 'items/stocks', only: %i(create destroy)
  end
end
