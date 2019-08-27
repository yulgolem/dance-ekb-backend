class AgeRangesGenerator
  def initialize(age_from = nil, age_to = nil)
    @age_from = age_from
    @age_to = age_to
  end

  def create!
    @age_range = AgeRange.create!(
      age_from: @age_from,
      age_to: @age_to
    )
  end
end

AgeRangesGenerator.new(3, 5).create!
AgeRangesGenerator.new(6, 7).create!
AgeRangesGenerator.new(5, 7).create!
AgeRangesGenerator.new(8, 11).create!
AgeRangesGenerator.new(13, 16).create!
