# create_table :performance_formats, force: :cascade do |t|
#   t.string :title
#   t.integer :participants_count_from
#   t.integer :participants_count_to
# end

class PerformanceFormat < ActiveRecord::Base

  has_many :nominations

end
