# create_table :performances, force: :cascade do |t|
#   t.bigint :collective_id
#   t.bigint :event_date_id
#   t.integer :age_from
#   t.integer :age_to
#   t.string :style
#   t.string :choreographer_full_name
#   t.integer :participants_count
#   t.string :title
#   t.boolean :from_dot, default: false
#   t.integer :priority
#   t.integer :status
#   t.bigint :nomination_id
#   t.bigint :style_id
#   t.index [:collective_id], name: :index_performances_on_collective_id
#   t.index [:event_date_id], name: :index_performances_on_event_date_id
#   t.index [:nomination_id], name: :index_performances_on_nomination_id
#   t.index [:style_id], name: :index_performances_on_style_id
# end

class Performance < ActiveRecord::Base

  belongs_to :collective
  belongs_to :event_date
  belongs_to :nomination
  belongs_to :style

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
