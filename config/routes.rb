# Define the application routes
Rails.application.routes.draw do
  
  # Routes for admin users
  authenticate :user, ->(user) { user.admin? } do
    # Mount the RailsAdmin engine at /admin
    mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
    # Mount the GoodJob engine at /good_job
    mount GoodJob::Engine => 'good_job'
  end
  
  # RESTful routes for venues
  resources :venues

  # RESTful routes for events
  resources :events do
    # Nested routes for messages within events
    resources :messages, only: [:index, :new, :create]
    # Nested routes for bouts within events
    resources :bouts, only: [:index, :new, :create] do
      # Further nested routes for results within bouts
      resources :results, only: [:new, :create]
    end
  end

  # Routes for user authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Root route
  root "landing#index"
  
  # Custom routes for fighters
  get("/fighters" => "user#index", as: :users)
  get("/fighters/carousel" => "user#carousel")
  get("/fighters/:username" => "user#show", as: :user) 

  # Route for creating swipes
  post 'swipes', to: 'swipes#create'

end
