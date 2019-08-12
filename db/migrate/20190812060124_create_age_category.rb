class CreateAgeCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :age_categories do |t|
      t.string :title
      t.references :event_date, foreign_key: true
    end
  end
end
