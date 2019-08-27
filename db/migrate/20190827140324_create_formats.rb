class CreateFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :formats do |t|
      t.string :title
      t.integer :participants_count_from
      t.integer :participants_count_to
    end

    change_table :nominations do |t|
      t.references :format, foreign_key: true
    end
  end
end
