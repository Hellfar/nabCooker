Rails.application.routes.draw do

  # all your other routes
  match '*unmatched', to: 'application#route_not_found', via: :all
end
