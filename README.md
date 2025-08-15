# TG-Twitter Poster

Приложение PowerShell для автоматической публикации контента из Telegram в Twitter с системой управления пользователями и приглашениями.

## 🎯 Описание

TG-Twitter Poster — это мощное приложение, которое автоматизирует процесс кросс-постинга сообщений из каналов Telegram в аккаунты Twitter. Приложение включает в себя продвинутую систему управления пользователями, авторизацию по приглашениям, управление множественными Twitter-приложениями и надёжное хранение данных в SQLite.

## ✨ Возможности

- 🔄 **Автоматический кросс-постинг** из Telegram в Twitter
- 👥 **Система управления пользователями** с ролями и правами
- 🎫 **Авторизация по приглашениям** для контроля доступа
- 📱 **Управление множественными Twitter-приложениями**
- 💾 **Хранение данных в SQLite** с полной структурой БД
- ⚙️ **Гибкая система конфигурации** через файлы настроек
- 📊 **Система логирования** и мониторинга
- 🔒 **Безопасное хранение** API-ключей и токенов
- ⏱️ **Настраиваемые интервалы** публикации
- 📈 **Ограничения по количеству** постов в день

## 📋 Требования

### Системные требования:
- Windows PowerShell 5.1 или PowerShell Core 6.0+
- .NET Framework 4.7.2 или .NET Core 3.1+
- Интернет-соединение для работы с API

### Модули PowerShell:
- `PSSQLite >= 1.1.0` - для работы с базой данных SQLite
- `PowerShellForGitHub >= 0.16.0` - для дополнительных возможностей

Все зависимости указаны в файле `requirements.txt`.

## 🚀 Пошаговая установка и настройка

### Шаг 1: Загрузка проекта
```bash
git clone https://github.com/Wizkhrus/tg-twitter-poster.git
cd tg-twitter-poster
```

### Шаг 2: Установка зависимостей PowerShell
```powershell
# Установка необходимых модулей
Install-Module -Name PSSQLite -Force -Scope CurrentUser
Install-Module -Name PowerShellForGitHub -Force -Scope CurrentUser
```

### Шаг 3: Создание базы данных
```powershell
# Выполнение SQL-скрипта для создания структуры БД
# В PowerShell запустите:
.\main.ps1
# Или импортируйте db.sql в SQLite напрямую
```

### Шаг 4: Настройка конфигурации
1. Скопируйте файл конфигурации:
   ```powershell
   Copy-Item config.example.txt config.txt
   ```

2. Отредактируйте `config.txt` и заполните ваши данные:
   ```ini
   [TELEGRAM]
   BOT_TOKEN=ваш_телеграм_бот_токен
   CHANNEL_ID=@ваш_телеграм_канал
   API_ID=ваш_telegram_api_id
   API_HASH=ваш_telegram_api_hash
   
   [TWITTER]
   BEARER_TOKEN=ваш_twitter_bearer_token
   CONSUMER_KEY=ваш_twitter_consumer_key
   CONSUMER_SECRET=ваш_twitter_consumer_secret
   ACCESS_TOKEN=ваш_twitter_access_token
   ACCESS_TOKEN_SECRET=ваш_twitter_access_token_secret
   ```

### Шаг 5: Настройка Twitter-приложений
1. Скопируйте файл примера приложений:
   ```powershell
   Copy-Item twitter_apps.txt twitter_apps_production.txt
   ```

2. Отредактируйте `twitter_apps_production.txt` с вашими данными:
   ```ini
   [APP_1]
   NAME=Моё Twitter-приложение
   CONSUMER_KEY=ваш_consumer_key
   CONSUMER_SECRET=ваш_consumer_secret
   ACCESS_TOKEN=ваш_access_token
   ACCESS_TOKEN_SECRET=ваш_access_token_secret
   ENABLED=true
   ```

## 🔑 Получение API-ключей

### Telegram API:
1. Перейдите на https://my.telegram.org/
2. Войдите с вашим номером телефона
3. Перейдите в "API development tools"
4. Создайте новое приложение
5. Скопируйте `api_id` и `api_hash`

### Telegram Bot Token:
1. Найдите @BotFather в Telegram
2. Отправьте команду `/newbot`
3. Следуйте инструкциям для создания бота
4. Скопируйте полученный токен

### Twitter API:
1. Перейдите на https://developer.twitter.com/
2. Подайте заявку на доступ к API
3. Создайте новое приложение
4. В разделе "Keys and tokens" сгенерируйте:
   - API Key (Consumer Key)
   - API Secret Key (Consumer Secret)
   - Access Token
   - Access Token Secret
   - Bearer Token
5. Убедитесь, что приложение имеет права на чтение и запись

## 💻 Использование

### Запуск приложения:
```powershell
.\main.ps1
```

### Основные команды:
- Приложение автоматически запустит мониторинг указанного Telegram-канала
- Новые сообщения будут автоматически публиковаться в Twitter
- Логи работы сохраняются в базе данных

## 📁 Структура файлов

```
tg-twitter-poster/
├── main.ps1                 # Основной файл приложения
├── config.example.txt       # Пример файла конфигурации
├── config.txt              # Ваш файл конфигурации (создать)
├── db.sql                  # SQL-скрипт для создания БД
├── twitter_apps.txt        # Пример конфигурации Twitter-приложений
├── requirements.txt        # Список зависимостей PowerShell
├── .gitignore             # Исключения для Git
├── LICENSE                # Лицензия MIT
├── README.md              # Документация (этот файл)
└── database.db            # База данных SQLite (создаётся автоматически)
```

## 🔧 Настройка системы приглашений

### Создание пригласительного кода:
```sql
INSERT INTO invitations (code, expires_at) 
VALUES ('INVITE2024', datetime('now', '+30 days'));
```

### Создание администратора:
```sql
INSERT INTO users (telegram_id, username, first_name, is_admin) 
VALUES (123456789, 'admin', 'Администратор', TRUE);
```

## 📊 Мониторинг и логи

Все операции логируются в таблицу `logs`:
- Уровни логирования: DEBUG, INFO, WARNING, ERROR
- Автоматическое отслеживание ошибок
- Статистика постов в таблице `posts`

## ⚠️ Важные замечания

1. **Безопасность**: Никогда не публикуйте файл `config.txt` или другие файлы с API-ключами
2. **Лимиты API**: Соблюдайте лимиты Twitter API (300 твитов в 3 часа для бесплатного доступа)
3. **Резервное копирование**: Регулярно создавайте резервные копии базы данных
4. **Обновления**: Следите за обновлениями API Twitter и Telegram

## 🐛 Решение проблем

### Типичные ошибки:

**Ошибка подключения к базе данных:**
```powershell
# Проверьте существование файла database.db
# Запустите скрипт создания БД заново
sqlite3 database.db < db.sql
```

**Ошибки Twitter API:**
- Проверьте права доступа вашего приложения
- Убедитесь в корректности токенов
- Проверьте не превышены ли лимиты API

**Ошибки Telegram API:**
- Убедитесь что бот добавлен в канал как администратор
- Проверьте корректность BOT_TOKEN
- Убедитесь в правильности CHANNEL_ID (должен начинаться с @)

## 🤝 Участие в разработке

1. Сделайте форк проекта
2. Создайте ветку для ваших изменений (`git checkout -b feature/amazing-feature`)
3. Зафиксируйте изменения (`git commit -m 'Add amazing feature'`)
4. Отправьте в ветку (`git push origin feature/amazing-feature`)
5. Создайте Pull Request

## 📄 Лицензия

Этот проект лицензирован под MIT License - подробности смотрите в файле [LICENSE](LICENSE).

## 🔗 Полезные ссылки

- [Telegram Bot API](https://core.telegram.org/bots/api)
- [Twitter API Documentation](https://developer.twitter.com/en/docs)
- [PowerShell Documentation](https://docs.microsoft.com/powershell/)
- [SQLite Documentation](https://sqlite.org/docs.html)

## 📞 Поддержка

Если у вас возникли вопросы или проблемы:

1. Проверьте раздел "Решение проблем" выше
2. Посмотрите существующие Issues в GitHub
3. Создайте новый Issue с подробным описанием проблемы
4. Приложите логи ошибок и конфигурацию (без API-ключей!)

---

**Сделано с ❤️ для сообщества разработчиков**
