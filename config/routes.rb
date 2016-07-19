Rails.application.routes.draw do
  root 'home#index'

  # あえてかもしれませんが、実際の開発ではDEVISE(https://github.com/plataformatec/devise)を使うケースが多いと思います。
  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, except: %i(index) do
    member do
      get 'items'
      get 'stocks'
      get 'tags'
      get 'followers'
      get 'following'
      get 'draft'
    end
    resource :follow_user, only: %i(create destroy)
  end
  resources :items do
    resources :comments, only: %i(create)
    resource :stock, only: %i(create destroy)
  end
  resources :tags, only: %i(show) do
    resource :follow_tag, only: %i(create destroy)
  end
end
