Rails.application.routes.draw do
  devise_for :users

  # all your other routes
  match '*unmatched', to: 'application#route_not_found', via: :all
end
