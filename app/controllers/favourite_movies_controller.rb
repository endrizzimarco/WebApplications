class FavouriteMoviesController < ApplicationController
  before_action :set_movie, only: [:create, :destroy]
  before_action :authenticate_user!, only:[:index]
    
  def index
    @movies = current_user.favourite_movies.order('api_id')
  end
  
  def create
    if Favourite.create(favourited: @movie, user: current_user)
      redirect_back(fallback_location:'', notice: I18n.t('favourite_movies.create.notice'))
    else
      redirect_back(fallback_location:'', alert: I18n.t('favourite_movies.create.alert'))
    end
  end
  
  def destroy
    Favourite.find_by(favourited_id: @movie.id, user_id: current_user.id).destroy
    redirect_back(fallback_location:'', notice: I18n.t('favourite_movies.destroy.notice'))
  end
  
  private
    def set_movie
      @movie = current_user.movies.find(params[:id])
    end
end