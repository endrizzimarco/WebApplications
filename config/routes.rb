Rails.application.routes.draw do
  devise_for :users
  resources :movies, only: [:create, :destroy, :index, :show]
  resources :favourite_movies, only: [:create, :destroy, :index]

  root 'movies#home'
  get 'search' => 'movies#search'
  get 'favourites' => 'favourite_movies#index'
end
