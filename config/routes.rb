Rails.application.routes.draw do
  
  root "blogs#index"
  devise_for :users
  resources :users, only: [:index, :show]
  
  resources :blogs do
    resources :comments
  end
  resources :categories, only: [:index, :show]
end
