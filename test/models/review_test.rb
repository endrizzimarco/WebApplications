require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = reviews(:valid)
  end

  test 'valid review' do
    assert @review.valid?
  end

  test 'empty not valid' do
    review = Review.new

    refute review.valid?
  end

  test 'invalid without comment' do
    @review.comment = nil
    refute @review.valid?
    assert_not_nil @review.errors[:comment]
  end

  test 'invalid without user_id' do
    @review.user_id = nil
    refute @review.valid?
    assert_not_nil @review.errors[:user_id]
  end

  test 'invalid without movie_id' do
    @review.movie_id = nil
    refute @review.valid?
    assert_not_nil @review.errors[:movie_id]
  end

  test 'invalid without movie_api_id' do
    @review.movie_api_id = nil
    refute @review.valid?
    assert_not_nil @review.errors[:movie_api_id]
  end

  test 'testing recent scope' do
    # Should include 4 most recent reviews
    assert_includes Review.recent(641), reviews(:one)
    assert_includes Review.recent(641), reviews(:three)
    assert_includes Review.recent(641), reviews(:four)
    assert_includes Review.recent(641), reviews(:five)

    #Should not include old reviews
    refute_includes Review.recent(641), reviews(:two)
    refute_includes Review.recent(641), reviews(:six)
  end
end
