# create_table :event_dates, force: :cascade do |t|
#   t.string :title
#   t.string :description
#   t.date :event_date
#   t.bigint :event_id
#   t.index [:event_id], name: :index_event_dates_on_event_id
# end

class EventDate < ActiveRecord::Base

  belongs_to :event
  has_one :performance_schedule

  def published?
    true
  end
end
