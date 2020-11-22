require 'test_helper'

class FavouriteMoviesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:user_one)
    post user_session_url
    @movie = movies(:movie_one)
  end


  test "should get index" do
    get favourite_movies_url
    assert_response :success
  end

  test "should create favourite movie" do
    assert_difference('Favourite.count') do
      post favourite_movies_path(id: @movie.id)
    end
  end
  
  test "should destroy favourite movie" do
    assert_difference('Favourite.count', -1) do
      delete favourite_movie_path(id: @movie.id)
    end
    assert_redirected_to '' # assert redirect back
  end
end
