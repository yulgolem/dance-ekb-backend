# create_table :performance_schedules, force: :cascade do |t|
#   t.bigint :event_date_id, null: false
#   t.string :title
#   t.string :comment
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
#   t.index [:event_date_id], name: :index_performance_schedules_on_event_date_id
# end

class PerformanceSchedule < ActiveRecord::Base

  has_many :performance_schedule_items
  accepts_nested_attributes_for :performance_schedule_items

  belongs_to :event_date

  has_many :performances, through: :performance_schedule_items

end
