Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
  end
  
  resources :weight_classes
  
  resources :venues
  resources :events do
    resources :messages
    resources :bouts do
      resources :results, only: [:new, :create]
    end
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "landing#index"
  
  get("/fighters" => "user#index", as: :users)
  get("/fighters/carousel" => "user#carousel")#bandaid
  get("/fighters/:username" => "user#show", as: :user) 

  post 'swipes', to: 'swipes#create'
  
  
  
end
