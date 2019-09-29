# frozen_string_literal: true
class PerformanceSchedule
  class Generate < BaseInteraction

    def run
      nominations = Nomination.all.order(:age_from)
      nominations.each do |nomination|
        PerformanceSchedule::GenerateFromNomination.execute(nomination: nomination)
      end

      PerformanceSchedule::CheckSchedule
    end
  end
end
