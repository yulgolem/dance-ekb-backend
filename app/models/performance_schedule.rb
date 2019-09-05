# create_table :performance_schedules, force: :cascade do |t|
#   t.integer :priority
#   t.bigint :nomination_id, null: false
#   t.bigint :performance_id, null: false
#   t.string :comment
#   t.index [:nomination_id], name: :index_performance_schedules_on_nomination_id
#   t.index [:performance_id], name: :index_performance_schedules_on_performance_id
# end

class PerformanceSchedule < ActiveRecord::Base

  include Concerns::Ranked

  belongs_to :nomination
  belongs_to :performance

  def title
    performance.title
  end

end
