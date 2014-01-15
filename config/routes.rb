CrazyJake::Application.routes.draw do

  resources :complete_surveys, only: [:index, :create]

  resources :qr_codes, only: [:index]

  resources :customers do
    resources :surveys do
      resources :reports, only: [:index]
      resources :questions do
        member do
          get 'down'
          get 'up'
        end
      end
    end
  end

end
