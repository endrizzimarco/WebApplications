class MovieDbService
  attr_reader :configuration

  def initialize
    @configuration = Tmdb::Configuration.new
    @key = Tmdb::Api.key(ENV["MOVIE_DB_KEY"])
    @tmdb = Tmdb::Movie
  end

  # Fetches current popular movies
  def popular
    @tmdb.popular
  end

  # Fetch details for a movie
  def movie_detail(id)
    return unless id
    casts_for(@tmdb.detail(id))
  end

  # Search movie name in moviedb database
  def find(keyword)
    @tmdb.find(keyword) if keyword
  end

  private
  # Adds cast to movie instance
  def casts_for(movie)
    movie.merge(
      'casts' => @tmdb.casts(movie['id']).map { |cast| cast['name'] }
    )
  end
end
