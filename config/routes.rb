CrazyJake::Application.routes.draw do

  resources :complete_surveys, only: [:index, :create]

  resources :qr_codes, only: [:index]

  resources :customers do
    resources :surveys do
      resources :questions
    end
  end

end
