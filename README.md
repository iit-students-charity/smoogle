# Google-Shmoogle

## Запуск

```bash
git clone https://github.com/iit-students-charity/smoogle.git
cd smoogle

bundle install
```

Создаём юзера в постгресе или поправляем config/database.yml, создаём базу:

```bash
rails db:create db:migrate
```

Идексируем файлы:

```ruby
rails c
> Crawler.index!
```

Запускаем сервер: `rails s`
