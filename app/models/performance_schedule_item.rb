# create_table :performance_schedule_items, force: :cascade do |t|
#   t.integer :priority
#   t.bigint :performance_id, null: false
#   t.bigint :performance_schedule_id, null: false
#   t.integer :nomination_id
#   t.index [:nomination_id], name: :index_performance_schedule_items_on_nomination_id
#   t.index [:performance_id], name: :index_performance_schedule_items_on_performance_id
#   t.index [:performance_schedule_id], name: :index_performance_schedule_items_on_performance_schedule_id
# end

class PerformanceScheduleItem < ActiveRecord::Base

  before_save :bind_nomination

  belongs_to :performance_schedule
  belongs_to :performance
  belongs_to :nomination, optional: true

  include Concerns::Ranked
  ranks :priority, with_same: [:nomination_id]

  def set_default_priority
    self.priority_position = :last
  end

  def bind_nomination
    binding.pry
    self.nomination_id = performance.nomination_id
  end

end
