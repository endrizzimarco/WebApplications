class MoviePresenter
  def initialize(movie)
    @movie = movie
  end

  # Unpack hashmap values
  def data
    OpenStruct.new(
      id: @movie['id'],
      title: @movie['original_title'],
      poster_path: @movie['poster_path'],
      genres: @movie['genres'].map { |genre| genre['name'] }.join(' / '),
      synopsis: @movie['overview'],
      vote_average: @movie['vote_average'],
      casts: @movie['casts'].join(','),
      tagline: @movie['tagline'],
      runtime: @movie['runtime'],
      release_date: @movie['release_date'],
      revenue: @movie['revenue']
    )
  end
end