class CreatePerformanceSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :performance_schedules do |t|
      t.references :event_date, index: true, foreign_key: true, null: false
      t.string :title
      t.string :comment

      t.timestamps
    end
  end
end
