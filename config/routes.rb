Rails.application.routes.draw do
  resources :short_urls, only: [:new]

  root to: 'short_urls#new'
end
