Rails.application.routes.draw do
  resources :messages
  resources :weight_classes
  
  resources :venues
  resources :events do
    resources :bouts
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "landing#index"
  
  get("/fighters" => "user#index", as: :users)
  get("/fighters/:username" => "user#show", as: :user) 
  
  
end
