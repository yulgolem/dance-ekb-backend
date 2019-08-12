# create_table :articles, force: :cascade do |t|
#   t.string :title
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
# end

class Article < ActiveRecord::Base
  def published?
    true
  end
end
