class NominationPresenter < BasePresenter

  def performances_in_schedule
    nomination = object
    performance_count = Performance.by_nomination(nomination).count
    scheduled_performance_count = nomination.performance_schedule_items.count
    klass = performance_count == scheduled_performance_count ? 'ui green label' : 'ui red label'

    h.content_tag(:span,
                  [performance_count, scheduled_performance_count].join('/'),
                  class: klass
    )
  end
end
