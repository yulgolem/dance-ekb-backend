# frozen_string_literal: true
class PerformanceSchedule
  class GenerateFromNomination < BaseInteraction

    attr_accessor :nomination, :nomination_id

    def nomination
      @nomination ||= Nomination.find(nomination_id)
    end

    def run
      performances = Performance.by_nomination(nomination)
      PerformanceScheduleItem.transaction do
        performances.each do |performance|
          raise ActiveRecord::Rollback unless performance.nomination_id
          nomination = Nomination.find(performance.nomination_id)
          next if performance.blank?
          performance_schedule = Performance.where(event_date_id: nomination.event_date_id).first
          attrs = {
              performance_id: performance.id,
              nomination_id: performance.nomination_id,
              performance_schedule_id: performance_schedule.id
          }
          PerformanceScheduleItem.create!(attrs)
        end
      end
    end

  end
end
