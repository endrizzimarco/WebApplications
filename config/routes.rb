Rails.application.routes.draw do
  devise_for :users
  resources :movies, except: [:new, :edit] do
    resources :reviews, except: [:show, :index]
  end
  resources :favourite_movies, only: [:create, :destroy, :index]

  root 'home#home'
  get 'popular' => 'movies#popular'
  get 'search' => 'movies#search'
  get 'contact' => 'home#contact'
  post 'request_contact' => 'home#request_contact'
end
