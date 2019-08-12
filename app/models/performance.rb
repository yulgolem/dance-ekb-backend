# create_table :performances, force: :cascade do |t|
#   t.bigint :collective_id
#   t.bigint :event_date_id
#   t.string :age
#   t.string :genre
#   t.string :choreograph_full_name
#   t.integer :participants_count
#   t.string :title
#   t.boolean :from_dot, default: false
#   t.integer :priority
#   t.integer :status
#   t.index [:collective_id], name: :index_performances_on_collective_id
#   t.index [:event_date_id], name: :index_performances_on_event_date_id
# end

class Performance < ActiveRecord::Base

  belongs_to :collective
  belongs_to :event_date

  enum status: {
    draft: 0,
    confirmed: 1,
    paid: 3,
    arrived: 4,
  }

  def published?
    true
  end
end
