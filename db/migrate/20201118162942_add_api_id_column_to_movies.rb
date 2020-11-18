class AddApiIdColumnToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :api_id, :integer
  end
end
