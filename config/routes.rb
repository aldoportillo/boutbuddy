Rails.application.routes.draw do
  
  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
    mount GoodJob::Engine => 'good_job'
  end
  
  resources :venues
  resources :events do
    resources :messages, only: [:index, :new, :create]
    resources :bouts, only: [:index, :new, :create] do
      resources :results, only: [:new, :create]
    end
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "landing#index"
  
  get("/fighters" => "user#index", as: :users)
  get("/fighters/carousel" => "user#carousel")
  get("/fighters/:username" => "user#show", as: :user) 

  post 'swipes', to: 'swipes#create'
  
  
  
end
