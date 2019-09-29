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

  validates :performance_id, presence: true, uniqueness: true

  include RankedModel
  ranks :priority
  # use priority_rank  on a model to find a distinct rank

  def self.order_fields
    [:priority]
  end

  before_validation :set_default_priority, on: :create # ensure that this callback prepends before_save from RankedModel

  def set_default_priority
    # ToDo Override on nomination regeneration
    self.priority_position = :last
  end

  def bind_nomination
    self.nomination_id = performance.nomination_id
  end

  def calculated_row_order_position
    self.siblings.where('priority < ?', self.priority).count + 1
  end

  def prior_siblings
    PerformanceScheduleItem
        .where(performance_schedule: performance_schedule)
        .where('priority < ?', priority)
        .order(:priority)
        .last(3)
  end

  def next_siblings
    PerformanceScheduleItem
        .where(performance_schedule: performance_schedule)
        .where('priority > ?', priority)
        .order(:priority)
        .limit(3)
  end

  def prior_sibling_same_collective?
    collective_id = performance.collective_id
    prior_sibling_collective_ids = prior_siblings.map{|item| item.performance.collective_id}
    prior_sibling_collective_ids.include?(collective_id)
  end

  def next_sibling_same_collective?
    collective_id = performance.collective_id
    next_sibling_collective_ids = next_siblings.map{|item| item.performance.collective_id}
    next_sibling_collective_ids.include?(collective_id)
  end

  def have_same_collective_in_siblings?
    prior_sibling_same_collective? || next_sibling_same_collective?
  end

end
