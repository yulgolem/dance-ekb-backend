class CreatePerformanceScheduleItem < ActiveRecord::Migration[5.2]
  def change
    create_table :performance_schedule_items do |t|
      t.integer :priority
      t.references :performance, index: true, foreign_key: true, null: false
      t.references :performance_schedule, index: true, foreign_key: true, null: false
    end
  end
end
