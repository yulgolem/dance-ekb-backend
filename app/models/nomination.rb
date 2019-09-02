# create_table :nominations, force: :cascade do |t|
#   t.string :title
#   t.integer :age_from
#   t.integer :age_to
#   t.bigint :event_id
#   t.bigint :event_date_id
#   t.bigint :style_id
#   t.bigint :format_id
#   t.index [:event_date_id], name: :index_nominations_on_event_date_id
#   t.index [:event_id], name: :index_nominations_on_event_id
#   t.index [:format_id], name: :index_nominations_on_format_id
#   t.index [:style_id], name: :index_nominations_on_style_id
# end

class Nomination < ActiveRecord::Base

  belongs_to :event_date
  belongs_to :event
  belongs_to :style
  has_many :performances


  def published?
    true
  end
end
