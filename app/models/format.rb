# create_table :formats, force: :cascade do |t|
#   t.string :title
#   t.integer :participants_count_from
#   t.integer :participants_count_to
# end

class Format < ActiveRecord::Base

  has_many :nominations

end
