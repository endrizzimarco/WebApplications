class RenameRatingColumnMovies < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :rating, :vote_average
  end
end
