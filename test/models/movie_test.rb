require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:valid)
  end

  test 'valid movie' do
    assert @movie.valid?
  end

  test 'empty not valid' do
    movie = Movie.new

    refute movie.valid?
  end

  test 'invalid without user_id' do
    @movie.user_id = nil
    refute @movie.valid?
    assert_not_nil @movie.errors[:user_id]
  end

  test 'invalid without api_id' do
    @movie.api_id = nil
    refute @movie.valid?
    assert_not_nil @movie.errors[:api_id]
  end

  test 'invalid without img_path' do
    @movie.img_path = nil
    refute @movie.valid?
    assert_not_nil @movie.errors[:img_path]
  end

  test 'invalid without title' do
    @movie.title = nil
    refute @movie.valid?
    assert_not_nil @movie.errors[:title]
  end

  test 'invalid without user_rating' do
    @movie.user_rating = nil
    refute @movie.valid?
    assert_not_nil @movie.errors[:user_rating]
  end

  test 'check review associations' do 
    assert_equal 2, @movie.reviews.size # There are 2 review fixtures with movie_id = movies(:valid)
  end 

  test 'user rating can not go above 10' do
    @movie.user_rating = 11
    refute @movie.valid?
    assert_not_nil @movie.errors[:user_rating]
  end

  test 'user rating can not go below 0' do
    @movie.user_rating = -1
    refute @movie.valid?
    assert_not_nil @movie.errors[:user_rating]
  end

  test 'api_id needs to be a number' do
    @movie.api_id = 'string'
    refute @movie.valid?
    assert_not_nil @movie.errors[:api_id]
  end

  test 'img_path from trusted sources' do
    @movie.img_path = "https://malicious_site.jpg"
    refute @movie.valid? 
    assert_not_nil @movie.errors[:img_path]

    @movie.img_path = "https://image.tmdb.org/t/p/w400/eLT8Cu357VOwBVTitkmlDEg32Fs.jpg"
    assert @movie.valid?

    @movie.img_path = "https://via.placeholder.com/400x560?text=Insane Fight Club"
    assert @movie.valid?
  end

  test 'if user delete movie from seen list it should be removed from favourites' do
    movie = movies(:one).destroy
    favourite = favourites(:one) # Linked to movies(:one)
    
    movie.destroy
    refute Favourite.exists?(favourited_id: @movie.id)
  end

  test 'test user_average method' do
    # 2 fixtures with scores 2 and 10, average should be 6
    assert_equal 0.6e1,  Movie.users_average(641)
  end
end
