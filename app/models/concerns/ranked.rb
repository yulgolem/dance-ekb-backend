module Concerns::Ranked
  extend ActiveSupport::Concern

  included do

    include RankedModel
    ranks :priority

    before_validation :set_default_priority, on: :create # ensure that this callback prepends before_save from RankedModel
  end

  private

  def set_default_priority
    self.priority_position = :first
  end

end
