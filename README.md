Система публикации из GitHub в WordPress
========================================

Данная система была создана для совмещения системы блог-публикации WordPress
и системы хранения кода GitHub. А именно для процесса подготовки и совместной работы
над текстом в GitHub - где можно сохранять изменения.

Но для просмотра, и комментирования - удобно использовать WordPress.

Данная система позволяет произвести обновление содержимого поста, полностью
на базе содержимого файла с GitHub.

Пока для системы не используется БД - данные берутся из config.yml файла,
где указано сопоставление поста в ВордПрессе с УРЛ из GitHub.


Последовательность действий такая:

1) Имеется страница с публикацией на github

2) Добавляю публикацию в WP - при это указываю реальное название, и 
оставляю статус как "Черновик", и нажимаю "Сохранить" (а не "Опубликовать"),
в этом случае публикация не будет отображена на главной (указывается необходимая категория и тэги).

3) Получаю ID записи что была создана в WP - это видно в URL строке, "post=770" - 
здесь  770 это идентификатор.

4) Открываю на редактирование файл "config.yml" - добавляю:

    - url: RAW_URL
      wp_id: 770
      title: raspberry-pi-ruby-web-server

Здесь RAW_URL - это прямая ссылка на исходник текста в GitHub.

Для примера, ссылка на просмотр в GitHub:

https://github.com/robotclass/robotclass/blob/master/articles/raspberry-pi-ruby-web-server/raspberry-pi-ruby-web-server.md

надо нажать на "Raw" кнопке - и откроется прямая ссылка на исходный код (в формате MarkDown):

https://raw.github.com/robotclass/robotclass/master/articles/raspberry-pi-ruby-web-server/raspberry-pi-ruby-web-server.md

эту ссылку надо и указать в config.yml файлике вместо "RAW_URL".

wp_id - это идентификатор статьи в WordPress

title - это просто заголовок, с которым страница будет отображена в списке

5) Стартуем приложение

    ruby app.rb


6) Открываем браузером http://localhost:4567

Видим список, что был загружен из 'config.yml' файла.

Видим строчку "raspberry-pi-ruby-web-server [#770] Update"

Нажимаем на ссылку "Update", переходим на диалог ввода логина и пароля для 
блога.

После подтверждения - система скачает с GitHub страничку, преобразует её из
формата MarkDown в html, и обновить содержимое поста в WordPress блоге.

Плюсом к этому - пост опубликуется (из состояния Черновик).


Замечания
---------

Пока предусмотрена обработка статей из формата MarkDown.

Разделитель "Читать далее", формируется из "---" указанного в отдельной строке
файла MarkDown.

По установке - требуются 2 гема: 'sinatra' и 'redcarpet'.