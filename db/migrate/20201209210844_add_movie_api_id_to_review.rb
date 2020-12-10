class AddMovieApiIdToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :movie_api_id, :integer
  end
end
