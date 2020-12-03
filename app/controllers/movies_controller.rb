class MoviesController < ApplicationController
  before_action :set_movie, only: [:destroy]
  before_action :set_movie_api, only: [:show, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :image_path

  # GET root
  def home 
    @movies = movie_service.popular
  end

  # GET /search
  def search
    if params[:q].present?
      @movies = movie_service.find(params[:q])
    end
  end

  # GET /movies
  def index
    @movies = current_user.movies.order(params[:sort])
  end

  # GET /movies/:id  where :id represents the id of the movie in the API
  def show
      # Shows API data if not saved, otherwise show movies table data
      
      if current_user 
        movie = current_user.movies.where(api_id: params[:id])
        if movie.exists?
          @movie = movie.first
        end
      end
  end

  # POST /movies
  def create
    # Fix for missing posters
    if @movie.img_path == (@root_path + 'w400')
      @movie.img_path = "https://via.placeholder.com/400x560?text=#{@movie.title}"
    end

    # Save the movie api data and the rating into the movies table
    @newmovie = current_user.movies.build(api_id: @movie.id, title: @movie.title, tagline: @movie.tagline, 
            vote_average: @movie.vote_average, genres: @movie.genres, casts: @movie.casts, synopsis: @movie.synopsis,
            runtime: @movie.runtime, release_date: @movie.release_date, img_path: @movie.img_path, user_rating: params[:user_rating])

    if @newmovie.save
      redirect_back fallback_location:'', notice: I18n.t('movies.create.notice')
    else
      redirect_back fallback_location:'', alert: I18n.t('movies.create.alert')
    end
  end

  # DELETE /movies/:id  where :id represents the primary key of the saved movie
  def destroy
    @movie.destroy
      redirect_to movies_url, notice: I18n.t('movies.destroy.notice')
  end


  private
    # Sets the movie to delete
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # themoviedb API connection and commands
    def movie_service
      @movie_service ||= MovieDbService.new
    end  
    
    # Sets root path for poster images
    def image_path
      @root_path ||= movie_service.configuration.secure_base_url
    end 

    # Fetch data of a movie from the api based on id
    def movie_detail
      movie_service.movie_detail(params[:id])
    end

    # @movie attributes are now the same for saved movies, .popular
    # movies and .find movies
    def set_movie_api
      @movie = MoviePresenter.new(movie_detail).data
      @movie[:img_path] = "#{image_path}w400#{@movie.poster_path}"
    end
end
