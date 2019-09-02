class CollectivesGenerator
  def initialize(city = nil, head_full_name = nil, title = nil, level = nil)
    @city = city
    @head_full_name = head_full_name
    @title = title
    @level = level
  end

  def create!
    @collective = Collective.create!(
      city: @city,
      head_full_name: @head_full_name,
      title: @title,
      level: @level,
    )
  end
end

CollectivesGenerator.new('Екатеринбург', 'Пахнутова Анжелика Александровна, педагог Журыбеда Алена Денисовна', 'Студия танца «Юнона»').create!
CollectivesGenerator.new('Невьянск', 'Кондюрина Юлия Андреевна', 'Пластилин').create!
CollectivesGenerator.new('Бисерть', 'Вишнякова Наталия Анатольевна', 'Студия танца «Антарес»').create!
CollectivesGenerator.new('Екатеринбург', 'Шамаева Ольга Николаевна', 'Студия эстрадного танца «Стихия»').create!
CollectivesGenerator.new('Екатеринбург', 'Сачкова Полина Антоновна', 'Young stars').create!
CollectivesGenerator.new('Екатеринбург', 'Егорова Анастасия Олеговна', 'Образцовый ансамбль современной и народной хореографии "Метеоритм"').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера" ').create!
