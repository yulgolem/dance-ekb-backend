# create_table :nominations, force: :cascade do |t|
#   t.string :title
#   t.bigint :event_id
#   t.bigint :event_date_id
#   t.bigint :genre_id
#   t.bigint :age_range_id
#   t.bigint :format_id
#   t.index [:age_range_id], name: :index_nominations_on_age_range_id
#   t.index [:event_date_id], name: :index_nominations_on_event_date_id
#   t.index [:event_id], name: :index_nominations_on_event_id
#   t.index [:format_id], name: :index_nominations_on_format_id
#   t.index [:genre_id], name: :index_nominations_on_genre_id
# end

class Nomination < ActiveRecord::Base

  belongs_to :event_date
  belongs_to :event
  has_many :performances


  def published?
    true
  end
end
