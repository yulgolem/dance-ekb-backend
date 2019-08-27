class GenresGenerator
  def initialize(title = nil)
    @title = title
  end

  def create!
    @genre = Genre.create!(
      title: @title,
    )
  end
end

GenresGenerator.new('Эстрадный танец').create!
GenresGenerator.new('Народный танец').create!
GenresGenerator.new('Детский танец').create!
