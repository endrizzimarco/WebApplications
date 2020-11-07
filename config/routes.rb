Rails.application.routes.draw do
  devise_for :users
  resources :movies

  root 'movies#index'
  get 'search' => 'movies#search'
  get 'showSearch' => 'movies#showSearch'
end
