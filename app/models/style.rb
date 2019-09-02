# create_table :styles, force: :cascade do |t|
#   t.string :title
#   t.string :comment
# end

class Style < ActiveRecord::Base

  has_many :performances
  has_many :nominations

end
