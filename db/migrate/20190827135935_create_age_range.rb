class CreateAgeRange < ActiveRecord::Migration[5.2]
  def change
    create_table :age_ranges do |t|
      t.integer :age_from
      t.integer :age_to
    end

    change_table :nominations do |t|
      t.references :age_range, foreign_key: true
    end
  end
end
