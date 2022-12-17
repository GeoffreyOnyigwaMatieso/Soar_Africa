Rails.application.routes.draw do
  resources :healths
  resources :r_bins
  resources :admins
  resources :academics
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
