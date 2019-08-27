class CreateGenre < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :title
      t.string :comment
    end

    change_table :performances do |t|
      t.references :genre, foreign_key: true
    end

    change_table :nominations do |t|
      t.references :genre, foreign_key: true
    end

    rename_column :performances, :genre, :style
  end
end
