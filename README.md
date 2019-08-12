## IMI Backend

### Запуск зависимостей

Локально Postgresql и redis запускаются в контейнерах docker.

OS X: нужно установить docker и docker-compose (можно через docker for Mac, если на маке)

После этого в папке проекта выполнить

    docker-compose up # можно с -d, чтобы процесс ушел в фон

Чтобы погасить все это, нужно остановить docker-compose (ctrl+c, или `docker-compose stop`, если они были запущены с `-d`).

### Database

Для создания БД и заполнения ее тестовыми данными нужно выполнить

    bundle exec rake db:create
    RAILS_ENV=test bundle exec rake db:create
    bundle exec rake db:schema:load
    bundle exec rake db:seed

Если БД, указанная в database.yml уже существует, то она будет предварительно удалена.
Перед запуском команды нужно погасить все процессы, использующие эту БД (сервер, консоль).

Восстановление дампа

    docker exec -i $(docker-compose ps -q db) psql -U postgres imi_backend_development < dump.sql

### Тесты

    bin/rspec

### Документация JSON API

Для генерации документации нужно выполнить

    RAILS_ENV=test bin/rake docs:generate

После этого при запущенном rails-сервере документация будет доступна по адресу {localhost:port}/api/docs

