# create_table :collectives, force: :cascade do |t|
#   t.string :city
#   t.string :head_full_name
#   t.string :title
#   t.string :level
# end

class Collective < ActiveRecord::Base

  def published?
    true
  end
end
