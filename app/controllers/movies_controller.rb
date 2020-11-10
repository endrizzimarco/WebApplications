class MoviesController < ApplicationController
  before_action :set_variables
  before_action :set_movie, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:create]

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
      @index = true
      @movies = current_user.movies
    end
  end

  def show
    @show = true
  end

  # GET /movies/1
  # GET /movies/1.json
  def view
    @movie = MoviePresenter.new(movie_detail).data
    @movie[:img_path] = "#{@image_path}w400#{@movie.poster_path}"
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully added to watchlist' }
      else
        format.html {  redirect_to @movie, alert: 'Something went wrong :(' }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
    end
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

    def set_variables
      @image_path ||= movie_service.configuration.base_url
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.permit(:movie_id, :title, :tagline, :rating, :genres, :casts, :synopsis, :runtime, :release_date, :img_path)
    end
end
