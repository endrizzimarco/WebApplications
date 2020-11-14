class MoviesController < ApplicationController
  before_action :set_movie, only: [:destroy]
  before_action :authenticate_user!, only: [:create]
  before_action :image_path, only: [:home, :search, :show, :create]

  def home 
    @movies = movie_service.popular
  end

  def search
    if params[:q].present?
      @movies = movie_service.find(params[:q])
    end
  end

  # GET /movies
  # GET /movies.json
  def index
    if current_user.present?
      @movies = current_user.movies.order("id")
    end
  end

  def show
      unless current_user and current_user.movies.exists?(id: params[:id]) 
        @movie = MoviePresenter.new(movie_detail).data
        @movie[:img_path] = "#{@root_path}w400#{@movie.poster_path}"
      else
        set_movie
      end
  end

  # POST /movies
  # POST /movies.json
  def create
    set_movie_api 

    @newmovie = current_user.movies.build(id: @movie.id, title: @movie.title, tagline: @movie.tagline, 
            vote_average: @movie.vote_average, genres: @movie.genres, casts: @movie.casts, synopsis: @movie.synopsis,
            runtime: @movie.runtime, release_date: @movie.release_date, img_path: @movie.img_path)

    if @newmovie.save
      redirect_to @newmovie, notice: 'Movied added to watched list' 
    else
      redirect_to @newmovie, alert: 'Something went wrong :(' 
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    if current_user.favourite_movies.exists?(id: @movie.id)
      Favourite.where(favourited_id: @movie.id, user_id: current_user.id).first.destroy
    end
    @movie.destroy
      redirect_to movies_url, notice: 'Movie was successfully destroyed.' 
  end

  def movie_service
    @movie_service ||= MovieDbService.new
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def image_path
      @root_path ||= movie_service.configuration.base_url
    end

    def movie_detail
      movie_service.movie_detail(params[:id])
    end

    def set_movie_api
      @movie = MoviePresenter.new(movie_detail).data
      @movie[:img_path] = "#{@root_path}w400#{@movie.poster_path}"
    end
end
