class CreateEventDates < ActiveRecord::Migration[5.2]
  def change
    create_table :event_dates do |t|
      t.string :title
      t.string :description
      t.date :event_date
      t.references :event, foreign_key: true
    end
  end
end
