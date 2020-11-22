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

  test "should get search" do
    get '/search?q=test'
    assert_response :success
  end

  test "should get index" do
    get movies_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post movies_url(), params: {id: @movie.api_id, user_rating: 10.0} 
    end
    
    #check created movie is populated with correct data from the api
    newmovie = Movie.last
    assert_equal(@movie.title, newmovie.title)
    assert_equal(@movie.vote_average, newmovie.vote_average)
    assert_equal(@movie.genres, newmovie.genres)
    assert_equal(@movie.casts, newmovie.casts.split(',')[0])
    assert_equal(@movie.synopsis, newmovie.synopsis)
    assert_equal(@movie.runtime, newmovie.runtime)
    assert_equal(@movie.release_date, newmovie.release_date)
    assert_equal(@movie.img_path, newmovie.img_path)
    assert_equal(@movie.tagline, newmovie.tagline)
    assert_equal(@movie.user_rating, newmovie.user_rating)
    assert_equal(@movie.api_id, newmovie.api_id)
    assert_equal(@movie.user_id, newmovie.user_id)
    
    assert_redirected_to '' # assert redirect back
  end

  test "should show movie" do 
    get movies_url(@movie.api_id)
    assert_response :success
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end
    assert_redirected_to movies_url
  end
end
