Rails.application.routes.draw do
  resources :short_urls, only: [:index, :new, :create, :show]

  root to: 'short_urls#new'
  get "/:id", to: "short_urls#show"
end
