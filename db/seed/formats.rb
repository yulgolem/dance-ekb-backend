class FormatsGenerator
  def initialize(title = nil, participants_count_from = nil, participants_count_to = nil)
    @title = title
    @participants_count_from = participants_count_from
    @participants_count_to = participants_count_to
  end

  def create!
    @format = Format.create!(
      title: @title,
      participants_count_from: @participants_count_from,
      participants_count_to: @participants_count_to,
    )
  end
end

FormatsGenerator.new('Соло-дуэт-трио', 1, 3).create!
FormatsGenerator.new('Ансамбль', 4, 8).create!
FormatsGenerator.new('Формейшн', 8).create!
