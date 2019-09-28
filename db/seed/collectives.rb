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
CollectivesGenerator.new('Екатеринбург', 'Смирнова В.А.', 'Арт-этюд . детский сад').create!
CollectivesGenerator.new('Камышлов', 'Черноскутова Наталия Романовна', 'Творческий коллектив «Первые шаги»').create!
CollectivesGenerator.new('Екатеринбург', 'Макарова Елена Васильевна', 'Коллектив "Созвездие" МАДОУ детский сад №38').create!
CollectivesGenerator.new('Екатеринбург', 'Тягушева Мария Александровна', 'Солнечные Зайчики').create!
CollectivesGenerator.new('Екатеринбург', 'Штанько Екатерина Владимировна', 'Студия танца «Dance Авеню», группа «Дебют»').create!
CollectivesGenerator.new('Екатеринбург', 'Завертаные Мария Александровна, Денис Васильевич', 'Коллектив эстрадного танца “В два счета!”').create!
CollectivesGenerator.new('Екатеринбург', 'Штанько Екатерина Владимировна', 'Студия танца «Dance Авеню», группа «Дети солнца»').create!
CollectivesGenerator.new('Екатеринбург', 'Костарева Алена Дмитриевна', '"Студия современного танца «PRO Движение»"').create!
CollectivesGenerator.new('п. Сосновый Бор', 'Шалаева Екатерина Валерьевна', 'Ансамбль эстрадного танца "Кристалл"').create!
CollectivesGenerator.new('Екатеринбург', 'Шубина Валерия Игоревна', '"Студия искусств «Вдохновение». Группа MiniDance."').create!
CollectivesGenerator.new('Первоуральск', 'Бурылова Светлана Альбертовна', 'Танцевальный коллектив «СОЛО»').create!
CollectivesGenerator.new('Екатеринбург', 'Гершкович Юлия Вячеславовна', '"Студия танца Хамелеон Группа: «Хамелеончики»"').create!
CollectivesGenerator.new('Екатеринбург', 'Гершкович Юлия Вячеславовна', '"Студия танца Хамелеон Группа: «Хамелеончики»"').create!
CollectivesGenerator.new('Асбест', 'Шалаева Екатерина Валерьевна', 'Ансамбль эстрадного танца «Кристалл»').create!
CollectivesGenerator.new('Екатеринбург', 'Тягушева Мария Александровна', 'НеМалыши').create!
CollectivesGenerator.new('Бисерть', 'Непутина Юлия Александровна', 'Танцевальная студия «Мармелад»').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера" Иванищева Диана').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера" Лапина София').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера" Секачева Варвара').create!
CollectivesGenerator.new('Невьянск', 'Секачев Игорь Вячеславович', 'Коллектив «Степ-балет»').create!
CollectivesGenerator.new('Екатеринбург', 'Зотова Елена Валерьевна', '"Хореографическая студия «ДиТэЯ» - дуэт Алексей Зотов и Полина Насонова"').create!
CollectivesGenerator.new('Екатеринбург', 'Бурмистрова Лада Сергеевна', '"Ситара" Месилова Лила"').create!
CollectivesGenerator.new('Екатеринбург', 'Зотова Елена Валерьевна', '"Хореографическая студия «ДиТэЯ» - Анастасия Пушкарева"').create!
CollectivesGenerator.new('Бисерть', 'Вишнякова Наталия Анатольевна', 'Студия танца «Антарес» Александрова Дарья').create!
CollectivesGenerator.new('Невьянск', 'Бабкина Ольга Николаевна', 'Народный коллектив ансамбль танца «Забияки»').create!
CollectivesGenerator.new('п. Сосновый бор', 'Ирина Николаевна Елисеева', 'Танцевальный коллектив «Мозаика» спутник «Народного коллектива» ансамбля танца «Сосновоборочка»').create!
CollectivesGenerator.new('Невьянск, пос. Цементный', 'Коношонок Инна Геннадьевна', 'Девичник').create!
CollectivesGenerator.new('Екатеринбург', 'Рук. Юровских Елена Сергеевна', 'Конфетти').create!
CollectivesGenerator.new('Бисерть', 'Животкова Любовь Александровна', 'Танцевальная студия « Спектр»').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» , группа "Радуга"').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» , группа "Радуга"').create!
CollectivesGenerator.new('Екатеринбург', 'Юровских Елена Сергеевна', '"Конфетти" Щедрова Дарья').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера"  Айдакова Софья').create!
CollectivesGenerator.new('Бисерть', 'Вишнякова Наталия Анатольевна', 'Студия танца «Антарес»    Абдуллина Алена').create!
CollectivesGenerator.new('Екатеринбург', 'Руденко Юлия Федоровна', 'Спортивный клуб "Премьера"  Кузнецова Ирина').create!
CollectivesGenerator.new('Ижевск', 'Татаркина Марина Борисовна', 'Театр танца "Волшебники времени"  Дронникова Ксения').create!
CollectivesGenerator.new('Ижевск', 'Татаркина Марина Борисовна', 'Театр танца "Волшебники времени"  Иванова Анна ,Дронникова Ксения').create!
CollectivesGenerator.new('Ижевск', 'Татаркина Марина Борисовна', 'Театр танца "Волшебники времени" Иванова Анна').create!
CollectivesGenerator.new('п. Буланаш', 'Смирнова Светлана Александровна', 'Студия современного танца «Гравитация»').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» группа «Тутти-фрутти»').create!
CollectivesGenerator.new('Екатеринбург', 'Шамаева Ольга Николаевна', 'Студия эстрадного танца «Фиеста»').create!
CollectivesGenerator.new('Екатеринбург', 'Штанько Екатерина Владимировна', '"Студия танца «Dance Авеню», группа «Искорки»"').create!
CollectivesGenerator.new('Невьянск', 'Кадцина Елена Николаевна', 'Творческое объединение «Жемчужина»').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» , группа "Belle pa"').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» , группа "Belle pa"').create!
CollectivesGenerator.new('п. Сосновый бор', 'Ольга Николаевна Решетникова', 'Танцевальный коллектив «Кристалл»').create!
CollectivesGenerator.new('Екатеринбург', 'Дылдина Ольга Алексеевна', 'Ритм плюс').create!
CollectivesGenerator.new('Екатеринбург', 'Штанько Екатерина Владимировна', 'Студия танца «Dance Авеню», группа «Карамель»').create!
CollectivesGenerator.new('Екатеринбург', 'Орлова Елена Евгеньевна,Абатурова Анастасия Алексеевна', 'Калинка').create!
CollectivesGenerator.new('Екатеринбург', 'Ахмедова Анна Олеговна', 'Fox star').create!
CollectivesGenerator.new('Невьянск', 'Полякова Жанна Викторовна', 'Творческое объединение «Студия звезд» коллектив бальных танцев «Аллеманд»').create!
CollectivesGenerator.new('Екатеринбург', 'Смирнова В.А.', 'Центр культуры "Садовый"').create!
CollectivesGenerator.new('Екатеринбург', 'Смирнова В.А.', 'Гимназия Арт-Этюд').create!
CollectivesGenerator.new('Екатеринбург', 'Безруких Полина Петровна', 'Танцевальный коллектив «Вертикаль»').create!
CollectivesGenerator.new('Невьянск', 'Кондюрина Юлия Андреевна', 'Пластилин').create!
CollectivesGenerator.new('Екатеринбург', 'Максакова Мария, Попова Анна', 'Little dance.com').create!
CollectivesGenerator.new('Каменск-Уральский', 'Цыляева Елизавета Сергеевна', 'DFM (Dance For Mass)').create!
CollectivesGenerator.new('Екатеринбург', 'Иванкович Екатерина Андреевна', 'Soul sisters').create!
CollectivesGenerator.new('Екатеринбург', 'Сачкова Полина Антоновна', 'The voguers').create!
CollectivesGenerator.new('Екатеринбург', 'Токарева Александра Игоревна', 'Power Rangers (пауэр рэнджэрс)').create!
CollectivesGenerator.new('Екатеринбург', 'Токарева Александра Игоревна', 'Mochi (мОти)').create!
CollectivesGenerator.new('Екатеринбург', 'Федотова Анастасия Вячеславовна', '"Танцевально-гимнастическая студия «Фейерверк» - Виктория Мажарова"').create!
