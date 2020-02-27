Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :concert_halls do
    resources :reservations, only: [:index, :new, :create]
  end
  resources :reservations, only: [:show, :destroy]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html]

end
