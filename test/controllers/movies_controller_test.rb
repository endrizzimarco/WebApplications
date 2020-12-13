require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get new_user_session_url
    sign_in users(:one)
    post user_session_url
    @movie = movies(:one)
    @movie_service = MovieDbService.new
  end

  test "should get popular" do 
    get popular_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_movieslist'
    assert_template partial: '_footer'
    
    exp = @movie_service.popular
    act = assigns(:movies)

    # Can't compare content of 2 Movie classes
    # Therefore testing that size is equal and random attributes of random elements match
    assert_equal exp.size, act.size
    assert_equal exp[0].title, act[0].title
    assert_equal exp[7].id, act[7].id 
    assert_equal exp[13].popularity, act[13].popularity
  end

  test "should get search" do
    # Getting the search page result for 'fight club'
    get '/search?q=fight+club'
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_movieslist'
    assert_template partial: '_footer'

    exp = @movie_service.find('fight club')
    act = assigns(:movies)

    assert_equal exp.size, act.size
    assert_equal exp[0].title, act[0].title
    assert_equal exp[2].runtime, act[2].runtime
    assert_equal exp[4].tagline, act[4].tagline
  end

  test "should get index" do
    get movies_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_sortby'
    assert_template partial: '_movieslist'
    assert_template partial: '_footer'

    act = assigns(:movies)
    exp = movies(:one) # Only movie assigned to user 1

    # Assertin only movie currently showing in index is movie 1
    assert_equal 1, act.size
    assert_equal exp.title, act.first.title
  end

  test "index should redirect to login page if not logged in" do
    get destroy_user_session_url

    get movies_url
    assert_redirected_to new_user_session_url
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post movies_url(), params: {id: @movie.api_id, user_rating: 10.0} 
    end
    
    # Check if created movie is populated with correct data from the api
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

  # Show view requires 3 separate test cases
  test "should show movie (whilst logged in and movie not saved)" do 
    @movie = movies(:two) # Not saved for user 1
    get movie_url(@movie.api_id)
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    act = @movie_service.movie_detail(@movie.api_id)
    exp = assigns(:movie)

    # Assuring controller is fetching correct data from the api
    assert_equal exp.title, act['title']
    assert_equal exp.tagline, act['tagline']
    assert_equal exp.release_date, act['release_date']

    # Assuring view is displaying correct data from api
    assert_select 'h4', act['tagline'] # Favourite stars
    assert_select 'span.alert-info', act['genre']
    assert_select 'span.alert-warning', act['release_date']  # Favourite stars

    # Testing elements that should not appear if movie is saved and you are not logged in
    assert_select 'a.glyphicon', count: 0 # Favourite stars
    assert_select 'button.btn-lg', count: 1 # Add to movie list button
    assert_select 'span.alert-success', count: 0 # 'Your rating' section
    assert_select 'a.btn-danger', count: 0 # Write review button

  end

  test "should show movie (whilst logged in and movie saved)" do 
    get movie_url(@movie.api_id)
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    # Testing elements that should not appear if movie isnt't saved but you are logged in
    assert_select 'a.glyphicon', count: 1 # Favourite stars
    assert_select 'button.btn-lg', count: 0 # Add to movie list button
    assert_select 'span.alert-success', count: 1 # 'Your rating' section
    assert_select 'a.btn-danger', count: 1 # Write review button
  end

  test "should show movie (whilst not logged in)" do 
    get destroy_user_session_url
    get movie_url(@movie.api_id)
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    # Testing elements that should not appear if user isn't logged in
    assert_select 'a.glyphicon', count: 0 # Favourite stars
    assert_select 'button.btn-lg', count: 0 # Add to movie list button
    assert_select 'span.alert-success', count: 0 # 'Your rating' section
    assert_select 'a.btn-danger', count: 0 # Write review button
  end

  test "should update movie" do
    patch movie_url(@movie), params: { user_rating: 1 } 
    assert_response :success
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end
    assert_redirected_to movies_url
  end
end
