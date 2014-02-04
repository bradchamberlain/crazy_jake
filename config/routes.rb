CrazyJake::Application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:show]

  resources :complete_surveys, only: [:index, :create]

  resources :qr_codes, only: [:index]

  resources :customers do
    resources :surveys do
        member do
          post "card"
        end
      resources :reports, only: [:index]  do
        member do
          post 'reporting_fields'
        end
      end
      resources :questions do
        member do
          get 'down'
          get 'up'
        end
      end
      resources :reporting_fields, except: [:show]
    end
    resources :payments, only: [:index, :create]
  end

  root :to => "customers#index"

end
