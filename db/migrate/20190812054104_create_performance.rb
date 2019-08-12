class CreatePerformance < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|
      t.references :collective, foreign_key: true
      t.references :event_date, foreign_key: true

      t.string :age
      t.string :genre
      t.string :choreograph_full_name
      t.integer :participants_count
      t.string :title
      t.boolean :from_dot, default: false, nil: false
      t.integer :priority
      t.integer :status


    end
  end
end
