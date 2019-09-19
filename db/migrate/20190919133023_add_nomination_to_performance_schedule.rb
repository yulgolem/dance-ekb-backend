class AddNominationToPerformanceSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :performance_schedule_items, :nomination_id, :integer
    add_index :performance_schedule_items, :nomination_id
  end
end
