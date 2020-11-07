class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.decimal :rating
      t.string :genres
      t.string :casts
      t.text :synopsis
      t.integer :runtime
      t.string :release_date
      t.string :img_url

      t.timestamps
    end
  end
end
