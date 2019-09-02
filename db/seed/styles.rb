class StylesGenerator
  def initialize(title = nil)
    @title = title
  end

  def create!
    @genre = Style.create!(
      title: @title,
    )
  end
end

StylesGenerator.new('Эстрадный танец').create!
StylesGenerator.new('Народный танец').create!
StylesGenerator.new('Детский танец').create!
