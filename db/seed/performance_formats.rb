class PerformanceFormatsGenerator
  def initialize(title = nil, participants_count_from = nil, participants_count_to = nil)
    @title = title
    @participants_count_from = participants_count_from
    @participants_count_to = participants_count_to
  end

  def create!
    @format = PerformanceFormat.create!(
      title: @title,
      participants_count_from: @participants_count_from,
      participants_count_to: @participants_count_to,
    )
  end
end

PerformanceFormatsGenerator.new('Соло-дуэт-трио', 1, 3).create!
PerformanceFormatsGenerator.new('Ансамбль', 4, 7).create!
PerformanceFormatsGenerator.new('Формейшн', 8, 999).create!
