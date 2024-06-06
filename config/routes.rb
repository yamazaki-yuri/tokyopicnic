Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :park_reports
  resources :parks, only: [:edit, :update, :show, :index] do
    collection do
      get 'autocomplete'
      get 'tokyo_ward_info'
    end
  end
  resources :park_images, only: [:new, :create]
  resources :report_images, only: [:new, :create, :destroy, :index]
  resource :profile, only: %i[show edit update]
  resources :bookmarks, only: %i[index create destroy]
  
  root 'tops#index'
  get '/search', to: 'parks#index', as: 'search'
  get '/mypage', to: 'users#index'
  get '/terms_of_service', to: 'tops#terms_of_service'
  get '/privacy_policy', to: 'tops#privacy_policy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
