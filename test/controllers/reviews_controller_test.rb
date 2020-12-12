require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_url
    sign_in users(:one)
    post user_session_url
    @review = reviews(:one)
  end

  test "should get new" do
    get new_movie_review_url(@review.movie_id)
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'form', count: 2
    assert_select 'h2', 'New Review'
    assert_select 'textarea.form-control[placeholder=?]', 'What did you think of the movie?'
    assert_select 'input[value=?]', 'Save'
    assert_select 'a', 'Back'
  end

  test "should create review" do
    assert_difference('Review.count') do
      post movie_reviews_url(@review.movie_id), params: { review: { comment: @review.comment } }
    end
    assert_redirected_to "/movies/#{@review.movie_api_id}"
  end

  test "should get edit" do
    get  edit_movie_review_url(@review.movie_id, @review)
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'form', count: 2
    assert_select 'h2', 'Editing Review'
    assert_select 'textarea.form-control[placeholder=?]', 'What did you think of the movie?'
    assert_select 'input[value=?]', 'Save'
    assert_select 'a', 'Back'
  end

  test "should update review" do
    patch movie_review_url(@review.movie_id, @review), params: { review: { comment: @review.comment } }
    assert_redirected_to "/movies/#{@review.movie_api_id}"
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete movie_review_url(@review.movie_id, @review)
    end
    assert_redirected_to ''
  end
end
