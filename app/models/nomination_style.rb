# create_table :nomination_styles, force: :cascade do |t|
#   t.bigint :nomination_id
#   t.bigint :style_id
#   t.integer :priority
#   t.index [:nomination_id], name: :index_nomination_styles_on_nomination_id
#   t.index [:style_id], name: :index_nomination_styles_on_style_id
# end

class NominationStyle < ActiveRecord::Base
  belongs_to :nomination
  belongs_to :style
end
