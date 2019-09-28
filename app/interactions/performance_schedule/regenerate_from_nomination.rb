# frozen_string_literal: true
class PerformanceSchedule
  class RegenerateFromNomination < BaseInteraction
    attr_accessor :nomination, :nomination_id

    def nomination
      @nomination ||= Nomination.find(nomination_id)
    end

    def run
      ranked_performance_items = PerformanceScheduleItem.rank(:priority)
      nomination_items = ranked_performance_items.where(nomination_id: nomination.id)
      first_nomination_rank = nomination_items.first&.priority_rank || :last

      nomination_items.destroy_all

      PerformanceSchedule::GenerateFromNomination.execute(nomination: nomination)

      nomination_items.reload
      nomination_items.reverse_each do |nomination_item|
        nomination_item.update priority_position: first_nomination_rank
      end

      PerformanceSchedule::CheckScheduleOrder
    end

  end
end
