class PerformanceSchedule
  class CheckSchedule < BaseInteraction
    THRESHOLD = 3

    def run
      check
    end

    def check
      PerformanceSchedule.all.each do |schedule|
        items = PerformanceScheduleItem.where(performance_schedule: schedule)
          .rank(:priority)

        items.count.times do
          items.reload
          calculate_positions(items)
        end
      end
    end

    def calculate_positions(items)
      last_item_rank = items.count - 1
      items_for_check = items.map { |item| [item.id, item.performance.collective.id] }.to_a
      items_for_check.each_with_index do |item, index|
        before_index = index - THRESHOLD
        before_index = 0 if before_index < 0

        after_index = index + THRESHOLD
        after_index = items_for_check.count - 1 if after_index > last_item_rank

        items_before = items_for_check[before_index...index]
        items_after = items_for_check[index + 1..after_index]

        result_before = items_before.detect { |element| element[1] == item[1] }
        if result_before
          first_item = PerformanceScheduleItem.find_by(id: result_before[0])
          second_item = PerformanceScheduleItem.find_by(id: item[0])
          separate(first_item, second_item, last_item_rank)
        end

        result_after = items_after.detect { |element| element[1] == item[1] }
        if result_after
          first_item = PerformanceScheduleItem.find_by(id: item[0])
          second_item = PerformanceScheduleItem.find_by(id: result_after[0])
          separate(first_item, second_item, last_item_rank)
        end
      end
    end

    def separate(first_item, second_item, last_item_rank)
      first_item_rank = first_item.priority_rank
      second_item_rank = second_item.priority_rank
      # сдвигать надо на следующее за пороговым значение минус разница ранков
      ranks_delta = THRESHOLD + 1 - (second_item_rank - first_item_rank)

      if first_item_rank - ranks_delta >= 0
        # можно сдвинуть первый элемент
        first_item.update(priority_position: first_item_rank - ranks_delta)
      else
        # проверим, можно ли сдвинуть второй элемент?
        if second_item_rank + ranks_delta <= last_item_rank
          # Сдвинуть можно
          second_item.update(priority_position: second_item_rank + ranks_delta)
        else
          # Просто делаем последним
          second_item.update(priority_position: :last)
        end
      end
    end
  end
end
