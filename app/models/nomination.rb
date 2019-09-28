# create_table :nominations, force: :cascade do |t|
#   t.string :title
#   t.integer :age_from
#   t.integer :age_to
#   t.bigint :event_id
#   t.bigint :event_date_id
#   t.bigint :performance_format_id
#   t.text :levels, default: [], array: true
#   t.index [:event_date_id], name: :index_nominations_on_event_date_id
#   t.index [:event_id], name: :index_nominations_on_event_id
#   t.index [:performance_format_id], name: :index_nominations_on_performance_format_id
# end

class Nomination < ActiveRecord::Base

  belongs_to :event_date
  belongs_to :event

  belongs_to :performance_format
  has_many :performances

  has_many :nomination_styles, dependent: :destroy, autosave: true
  has_many :styles, through: :nomination_styles

  has_many :performance_schedule_items

  def published?
    true
  end

  def levels=(vals)
    self['levels'] = (vals || []).reject(&:blank?)
  end
end
