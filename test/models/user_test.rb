require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
  end

  test 'empty not valid' do
    user = User.new

    refute user.valid?
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'invalid without password' do
    @user.encrypted_password = nil
    refute @user.valid?
    assert_not_nil @user.errors[:encrypted_password]
  end

  test 'check movies association' do
    assert_equal 2, @user.movies.size
  end

  test 'should destroy movies with user' do
    movie = movies(:two) # linked to users(:valid)
    @user.destroy

    refute Movie.exists?(movie.id) #check movie is destroyed with user
  end

  # 3 reviews fixtures set up with user_id: 3
  test 'check reviews association' do
    assert_equal 3, @user.reviews.size
  end

  test 'should destroy reviews with user' do
    review = reviews(:six) # linked to users(:valid)
    @user.destroy

    refute Review.exists?(review.id) #check review is destroyed with user
  end

  # 3 reviews fixtures set up with user_id: 3
  test 'check favourites association' do
    assert_equal 2, @user.favourites.size
  end

  test 'should destroy favourites with user' do
    favourite = favourites(:one) 
    @user.destroy

    refute Favourite.exists?(favourite.id) 
  end

end
