class RenameGenreToStyle < ActiveRecord::Migration[5.2]
  def change
    rename_column :nominations, :genre_id, :style_id
    rename_column :performances, :genre_id, :style_id
    rename_table :genres, :styles
  end
end
