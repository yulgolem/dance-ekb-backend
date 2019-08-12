# create_table :events, force: :cascade do |t|
#   t.string :title
#   t.integer :type
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
# end

class Event < ActiveRecord::Base
  enum type: {
    festival: 0,
    contest: 1,
  }

  has_many :event_dates

  def published?
    true
  end
end
