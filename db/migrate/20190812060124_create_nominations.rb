class CreateNominations < ActiveRecord::Migration[5.2]
  def change
    create_table :nominations do |t|
      t.string :title
      t.integer :age_from
      t.integer :age_to
      t.references :event_date, foreign_key: true
    end

    change_table :performances do |t|
      t.references :nomination, foreign_key: true
    end
  end
end
