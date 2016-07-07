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
    resources :follow_tag, controller: 'users/follow_tags', only: %i(index)
  end
  resources :items do
    resources :comments, only: %i(create)
    resource :stock, only: %i(create destroy)
  end
  resources :tags, only: %i(show) do
    resource :follow_user, controller: 'tags/follow_tags', only: %i(create destroy)
  end
end
