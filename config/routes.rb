Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users
  get 'users' => 'users#index'
  
  resources :books
  post "/books" => "books#create", as: "create"
  get "/home/about" => "homes#about", as: "about"
end
