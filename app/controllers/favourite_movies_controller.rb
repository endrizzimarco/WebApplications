class FavouriteMoviesController < ApplicationController
  before_action :set_movie, except: [:index]
    
  def index
    @movies = current_user.favourite_movies
  end
  
  def create
    if Favourite.create(favourited: @movie, user: current_user)
      redirect_to @movie, notice: 'Movie has been favourited'
    else
      redirect_to @movie, alert: 'Something went wrong :('
    end
  end
  
  def destroy
    Favourite.where(favourited_id: @movie.id, user_id: current_user.id).first.destroy
    redirect_to @movie, notice: 'Movie is no longer in favourites'
  end
  
  private
    def set_movie
      @movie = Movie.find(params[:movie_id] || params[:id])
    end
end