# create_table :styles, force: :cascade do |t|
#   t.string :title
#   t.string :comment
# end

class Style < ActiveRecord::Base

  has_many :performances

  has_many :nomination_styles, dependent: :destroy
  has_many :nominations, through: :nomination_styles

end
