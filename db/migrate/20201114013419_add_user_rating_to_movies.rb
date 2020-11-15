class AddUserRatingToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :user_rating, :integer
  end
end
