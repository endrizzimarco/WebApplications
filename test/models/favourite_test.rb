require 'test_helper'

class FavouriteTest < ActiveSupport::TestCase
  def setup
    @favourite = favourites(:valid)
  end

  test 'favourite valid' do
    favourite = Favourite.new

    refute favourite.valid?
  end

  test 'empty not valid' do
    favourite = Favourite.new

    refute favourite.valid?
  end

  test 'invalid without user_id' do
    @favourite.user_id = nil
    refute @favourite.valid?
    assert_not_nil @favourite.errors[:user_id]
  end

  test 'invalid without favourited_id' do
    @favourite.favourited_id = nil
    refute @favourite.valid?
    assert_not_nil @favourite.errors[:user_id]
  end

  test 'invalid without favourited_type' do
    @favourite.favourited_type = nil
    refute @favourite.valid?
    assert_not_nil @favourite.errors[:favourited_type]
  end
end
