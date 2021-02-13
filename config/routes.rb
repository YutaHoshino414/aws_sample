Rails.application.routes.draw do

  root "blogs#index"
  devise_for :users
  resources :users, only: [:index, :show]
  
  resources :blogs do
    resources :comments
    member do #member doを使うと、idを必要とする固有のルーティングを生成
      get :purchase
      get :pay
      patch :pay
    end
  end
  resources :categories, only: [:index, :show]
end
