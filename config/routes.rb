Rails.application.routes.draw do
  get '/meals/unselect_diet', to: 'meals#unselect_diet', as: 'unselect_diet'
  get '/meals/:id/select_diet', to: 'meals#select_diet', as: 'select_diet'
  get '/meals/:id/validate', to: 'meals#validate', as: 'validate'
  get '/meals/:id/favorite', to: 'meals#favorite', as: 'favorite'
  resources :meals

  devise_for :users

  root 'pages#index'

  # all your other routes
  match '*unmatched', to: 'application#route_not_found', via: :all
end
