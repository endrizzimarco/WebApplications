require 'test_helper'

class FavouriteMoviesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_url
    sign_in users(:one)
    post user_session_url
    @movie = movies(:one)
  end

  test "should get index" do
    get favourite_movies_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_sortby'
    assert_template partial: '_movieslist'
    assert_template partial: '_footer'

    act = assigns(:movies)
    exp = favourites(:two) #only favourite movie assigned to user 1

    # Only movie currently showing in index is movie 1
    assert_equal 1, act.size
    assert_equal exp.favourited_id, act.first.id
  end
  
  test "index should redirect to login page if not logged in" do
    get destroy_user_session_url

    get favourite_movies_url
    assert_redirected_to new_user_session_url
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
