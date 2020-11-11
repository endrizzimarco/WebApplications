class MoviesController < ApplicationController
  before_action :set_movie, only: [:destroy]
  before_action :authenticate_user!, only: [:create]
  before_action :image_path, only: [:home, :search, :show]

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
      @movies = current_user.movies
    end
  end

  def show
      unless current_user and current_user.movies.exists?(id: params[:id]) 
        set_movie_api
      else
        set_movie
      end
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.build(movie_params)

    if @movie.save
      redirect_to @movie, notice: 'Movied added to watched list' 
    else
      redirect_to @movie, alert: 'Something went wrong :(' 
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
      redirect_to movies_url, notice: 'Movie was successfully destroyed.' 
  end

  def movie_detail
    movie_service.movie_detail(params[:id])
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
      @image_path ||= movie_service.configuration.base_url
    end
    
    def set_movie_api
      @movie = MoviePresenter.new(movie_detail).data
      @movie[:img_path] = "#{@image_path}w400#{@movie.poster_path}"
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.permit(:id, :title, :tagline, :vote_average, :genres, :casts, :synopsis, :runtime, :release_date, :img_path)
    end
end
