# create_table :nominations, force: :cascade do |t|
#   t.string :title
#   t.integer :age_from
#   t.integer :age_to
#   t.bigint :event_id
#   t.bigint :event_date_id
#   t.index [:event_date_id], name: :index_nominations_on_event_date_id
#   t.index [:event_id], name: :index_nominations_on_event_id
# end

class Nomination < ActiveRecord::Base

  belongs_to :event_date
  belongs_to :event
  has_many :performances


  def published?
    true
  end
end
