module Concerns::PublishedByDefault
  extend ActiveSupport::Concern

  included do
    scope :published, -> { all }
  end

  def published?
    true
  end
end
