class RenameImgUrlColumnToImgPath < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :img_url, :img_path
  end
end
