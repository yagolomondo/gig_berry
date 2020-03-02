Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { :registrations => :registrations }

  root to: 'pages#home'

  resources :concert_halls do
    resources :reservations, only: [:index, :new, :create]
  end

  resources :users, only: %i[show] do
    resources :reservations, only: [:index]
  end

  resources :reservations, only: [:show, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "users/:user_id/concert_halls", to: "concert_halls#display", as: :users_concert_halls

end

