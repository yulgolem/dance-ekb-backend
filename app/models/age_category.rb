# create_table :age_categories, force: :cascade do |t|
#   t.string :title
#   t.bigint :event_date_id
#   t.index [:event_date_id], name: :index_age_categories_on_event_date_id
# end

class AgeCategory < ActiveRecord::Base

  belongs_to :event_date

  def published?
    true
  end
end
