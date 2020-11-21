require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:user_one)
    post user_session_url
    @movie = movies(:movie_one)
  end

  test "should get home" do 
    get root_url
    assert_response :success
  end

  test "should get index" do
    get movies_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post movies_url(), params: {id: @movie.api_id, user_rating: @movie.user_rating } 
    end

    assert_redirected_to '' # assert redirect back
  end

  test "should show movie" do
    get movie_url(@movie.api_id)
    assert_response :success
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie.api_id)
    end

    assert_redirected_to movies_url
  end

  test "should get search" do
    get '/search?q=test'
  end

  test "should not show index if not logged in" do
    get '/users/sign_out'
    get movies_url
    assert_response :error
  end



  test "should show view for saved movie" do 
  end
end
