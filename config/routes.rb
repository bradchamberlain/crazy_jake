CrazyJake::Application.routes.draw do

  devise_for :users
  resources :users, except: [:show]

  resources :complete_surveys, only: [:index, :create]

  resources :qr_codes, only: [:index]

  resources :customers do
    resources :surveys do
        member do
          get "card"
        end
      resources :reports, only: [:index]
      resources :questions do
        member do
          get 'down'
          get 'up'
        end
      end
    end
  end

  root :to => "customers#index"

end
