Rails.application.routes.draw do
  resources :meals
  get '/meals/:id/validate', to: 'meals#validate', as: 'validate'
  get '/meals/:id/favorite', to: 'meals#favorite', as: 'favorite'

  devise_for :users

  root 'pages#index'

  # all your other routes
  match '*unmatched', to: 'application#route_not_found', via: :all
end
