Rails.application.routes.draw do
  resources :weight_classes
  resources :bouts
  resources :venues
  resources :events
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "landing#index"
  
  get("/fighters" => "user#index")
  get("/fighters/:username" => "user#show", as: :user) 
  
end
