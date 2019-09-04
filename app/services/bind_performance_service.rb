class BindPerformanceService

  def self.nominations_hash
    Nomination.all.each_with_object({}) do |nomination, object|
      object[nomination.id] ||= []
      performance_ids = Performance.by_nomination(nomination).pluck(:id)
      object[nomination.id] = performance_ids
    end
  end

  def self.nomination_ids_for_performance(performance)
    return nil unless performance
    nominations_hash.select{ |_key, value| value.include?(performance.id) }.keys
  end

  def self.nominations_title_for_performance(performance)
    Nomination.where(id: nomination_ids_for_performance(performance)).map(&:title).join('/')
  end

  def self.nominations_count_for_performance(performance)
    nomination_ids_for_performance(performance).count
  end

end
