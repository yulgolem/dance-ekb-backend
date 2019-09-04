# create_table :performances, force: :cascade do |t|
#   t.bigint :collective_id
#   t.bigint :event_date_id
#   t.integer :age_from
#   t.integer :age_to
#   t.string :style
#   t.string :choreographer_full_name
#   t.integer :participants_count
#   t.string :title
#   t.boolean :from_dot, default: false
#   t.integer :priority
#   t.integer :status
#   t.bigint :nomination_id
#   t.bigint :style_id
#   t.index [:collective_id], name: :index_performances_on_collective_id
#   t.index [:event_date_id], name: :index_performances_on_event_date_id
#   t.index [:nomination_id], name: :index_performances_on_nomination_id
#   t.index [:style_id], name: :index_performances_on_style_id
# end

class Performance < ActiveRecord::Base
  belongs_to :collective
  belongs_to :event_date
  belongs_to :nomination, optional: true
  belongs_to :style

  enum status: {
    draft: 0,
    confirmed: 1,
    paid: 3,
    arrived: 4,
  }

  CONFIRMED_STATUSES = [
      :confirmed,
  ]

  scope :by_age_from, ->(nomination) { where("age_from >= ?", nomination.age_from) }
  scope :by_age_to, ->(nomination) { where("age_to <= ?", nomination.age_to) }
  scope :by_format_from, ->(nomination) { where("participants_count >= ?", nomination.format.participants_count_from) }
  scope :by_format_to, ->(nomination) { where("participants_count <= ?", nomination.format.participants_count_to || 999) }
  scope :by_style, ->(nomination) { where(style_id: nomination.styles.pluck(:id)) }

  scope :by_nomination, ->(nomination) {
                          by_age_from(nomination)
                            .by_age_to(nomination)
                            .by_format_from(nomination)
                            .by_format_to(nomination)
                            .by_style(nomination)
                        }

  scope :confirmed, -> { where(status: Performance.statuses.values_at(*CONFIRMED_STATUSES) ) }

  def published?
    true
  end

  def nomination_title
    ::BindPerformanceService.nominations_title_for_performance(self)
  end

  def nominations_count
    ::BindPerformanceService.nominations_count_for_performance(self)
  end

  def nomination_ids
    ::BindPerformanceService.nomination_ids_for_performance(self)
  end
end
