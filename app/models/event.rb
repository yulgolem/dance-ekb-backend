# create_table :events, force: :cascade do |t|
#   t.string :title
#   t.integer :event_type
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
# end

class Event < ActiveRecord::Base
  enum event_type: {
    festival: 0,
    contest: 1,
  }

  has_many :event_dates
  has_many :nominations

  def published?
    true
  end
end
