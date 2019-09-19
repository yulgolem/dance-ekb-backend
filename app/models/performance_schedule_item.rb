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

  include RankedModel
  ranks :priority, with_same: [:nomination_id]

  def self.order_fields
    [:nomination_id, :priority]
  end

  before_validation :set_default_priority, on: :create # ensure that this callback prepends before_save from RankedModel

  def set_default_priority
    self.priority_position = :last
  end

  def bind_nomination
    self.nomination_id = performance.nomination_id
  end

end
