Rails.application.routes.draw do
  devise_for :users
  resources :movies, except: [:new, :edit, :update]
  resources :favourite_movies, only: [:create, :destroy, :index]

  root 'movies#home'
  get 'search' => 'movies#search'
  get 'view' => 'movies#view'
  get 'favourites' => 'favourite_movies#index', as: 'favourites'
end
