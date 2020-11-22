class FavouriteMoviesController < ApplicationController
  before_action :set_movie, only: [:create, :destroy]
    
  def index
    @movies = current_user.favourite_movies.order("api_id")
  end
  
  def create
    if Favourite.create(favourited: @movie, user: current_user)
      redirect_back(fallback_location:'', notice: 'Movie has been favourited')
    else
      redirect_back(fallback_location:'', alert: 'Something went wrong :(')
    end
  end
  
  def destroy
    Favourite.where(favourited_id: @movie.id, user_id: current_user.id).first.destroy
    redirect_back(fallback_location:'', notice: 'Movie is no longer in favourites')
  end
  
  private
    def set_movie
      @movie = current_user.movies.find(params[:id])
    end
end