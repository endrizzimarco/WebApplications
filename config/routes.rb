Rails.application.routes.draw do
  devise_for :users
  resources :movies

  root 'movies#home'
  get 'search' => 'movies#search'
  get 'view' => 'movies#view'
end
