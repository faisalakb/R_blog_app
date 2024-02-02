Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:index, :new, :create, :destroy]
      resources :likes, only: [:create]
      member do
        delete :destroy
      end
    end
  end

  # Remove the redundant resources :posts block
  resources :comments do
    member do
      delete :destroy
    end
  end

  # API routes
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index]
    end
    resources :posts, only: [] do
      resources :comments, only: [:index, :create]
    end

    get '/users/:user_id/posts/:post_id/comments', to: 'comments#index'
    post '/users/:user_id/posts/:post_id/comments', to: 'comments#create'
  
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "users#index"
end
