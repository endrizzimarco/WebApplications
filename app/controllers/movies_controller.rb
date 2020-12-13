class MoviesController < ApplicationController
  before_action :set_movie, only: [:destroy, :update]
  before_action :set_movie_api, only: [:show, :create]
  before_action :authenticate_user!, only: [:index]
  before_action :image_path

  # GET /popular
  def popular
    @movies = movie_service.popular # Returns array of currently trending movies
  end

  # GET /search
  def search
    if params[:q].present?
      @movies = movie_service.find(params[:q]) # Search in moviedb API
    end
  end

  # GET /movies
  def index
    @movies = current_user.movies.order(params[:sort])
  end

  # GET /movies/:id  where :id represents the id of the movie in the API
  def show
      # Defaults to showing move data from api (before_action :set_movie_api)

      # If movie has been saved for current user, showed saved data instead
      if current_user and current_user.movies.saved(params[:id]).exists?
        @movie = current_user.movies.saved(params[:id]).first
        @reviews = Review.recent(@movie.api_id)
      end
  end

  # POST /movies
  def create
    # Use a placeholder image for missing API posters
    if @movie.img_path == (@root_path + 'w400')
      @movie.img_path = "https://via.placeholder.com/400x560?text=#{@movie.title}"
    end

    # If no stars are pressed set score to 0
    if params[:user_rating].empty?
      params[:user_rating] = 0
    end

    # Save the movie api data and the rating into the movies table
    # Only user_rating needs to be checked with strong parameters as other data comes from the API
    @newmovie = current_user.movies.build(api_id: @movie.id, title: @movie.title, tagline: @movie.tagline, 
            vote_average: @movie.vote_average, genres: @movie.genres, casts: @movie.casts, synopsis: @movie.synopsis,
            runtime: @movie.runtime, release_date: @movie.release_date, img_path: @movie.img_path, 
            user_rating: params.permit(:user_rating)[:user_rating])

    if @newmovie.save
      redirect_back fallback_location: '', notice: I18n.t('movies.create.notice')
    else
      redirect_back fallback_location: '', alert: I18n.t('movies.create.alert')
    end
  end

  # PATCH/PUT /movies/:id where :id represents the primary key of the saved movie
  def update
    @movie.user_rating = params.permit(:score)[:score]
    if @movie.save
      redirect_back fallback_location: ''
    end
  end

  # DELETE /movies/:id  where :id represents the primary key of the saved movie
  def destroy
    if @movie.destroy
      redirect_to movies_url, notice: I18n.t('movies.destroy.notice')
    end
  end


  private
    # Sets the movie to delete or update
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

    # Populate @movie with movie data fetched from API
    # MoviePresenter helps fetching attributes from hashmap and sets them to same variable names as Movie database
    def set_movie_api
      @movie = MoviePresenter.new(movie_detail).data
      @movie[:img_path] = "#{image_path}w400#{@movie.poster_path}"
      @reviews = Review.recent(@movie.id)
    end
end
