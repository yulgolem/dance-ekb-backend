class CreatePerformanceSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :performance_schedules do |t|
      t.integer :priority
      t.references :nomination, index: true, foreign_key: true, null: false
      t.references :performance, index: true, foreign_key: true, null: false
      t.string :comment
    end
  end
end
