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

  resources :comments, only: [:destroy] # Move delete action outside nested resources

  # API routes
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "users#index"
end
