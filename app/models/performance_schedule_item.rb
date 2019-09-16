# create_table :performance_schedule_items, force: :cascade do |t|
#   t.integer :priority
#   t.bigint :performance_id, null: false
#   t.bigint :performance_schedule_id, null: false
#   t.index [:performance_id], name: :index_performance_schedule_items_on_performance_id
#   t.index [:performance_schedule_id], name: :index_performance_schedule_items_on_performance_schedule_id
# end

class PerformanceScheduleItem < ActiveRecord::Base

  belongs_to :performance_schedule
  belongs_to :performance

  include Concerns::Ranked

end
