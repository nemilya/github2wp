TODO
====

Этап 1
------

* добавить Bootstrap2 (3) [done]
* преобазовать в haml [done]
* добавить обработку первой строки из Markdown файла, 
как заголовок поста и соотв. не добавлять его в содержимое
* добавить в конфиг пароль на доступ в систему [done]
* добавить Gemfile [done]
* поднять стенд на Heroku [done]
* добавить callback на push в github репозиторий, для автоматического
обновления соответсвующей WP страницы
* создание тестовой страницы где можно указать все параметры 
напрямую - без конфиг файла [done]
* добавить настройку для текстового хедера и футера 
сгенерированной страницы [done - пока вывод текста]
* добавить указание пароля на вход через переменную окружения "github2wp-pwd" [done]
* добавить указание конфиг файла через переменную окружения "github2wp-config"
как ссылку [done]
* кэширование внешнего конфига, указание информации в футере, 
перезагрузка внешнего конфига [done]

Этап 2
------

* добавить бэкэнд из БД
* добавить автоматическое создание публикации на базе github источника, с 
сохранением ID в БД
* добавить обработку URL GitHub - для извлечения ссылки на Row
* добавить вход/авторизацию через GitHub - тогда список авторизованных логинов Github
