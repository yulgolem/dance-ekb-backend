class PerformanceSchedule
  class CheckScheduleOrder < BaseInteraction

    def run
      PerformanceSchedule.all.each do |schedule|
        items = PerformanceScheduleItem.where(performance_schedule: schedule).rank(:priority)
        items.each_with_index do |value, index|
          a = value
          b = items.to_a[index + 1]
          next if b.blank?
          if a.performance.collective == b.performance.collective
            if b == items.last
              a.update(priority_position: :down)
            else
              b.update(priority_position: :up)
            end
          end
        end
      end
    end

  end
end
