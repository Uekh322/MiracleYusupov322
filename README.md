# Чудо Обувь

WPF, .NET Framework 4.7.2, Entity Framework 6.2, SQL Server LocalDB.

1. Подключитесь в SSMS к `(localdb)\MSSQLLocalDB`. Запустите [TrainingScript.sql](TrainingScript.sql) на экземпляре, где базы `MiracleShowTraining` ещё нет. Скрипт создаст базу и загрузит учебные данные.
2. Откройте `YusupovMiracle.sln` в Visual Studio. Восстановите пакеты NuGet, соберите решение и запустите проект.
3. Для входа используйте учебный логин `isivanov` (администратор), `papetrov` (менеджер) или `asidorova` (пользователь). Администратору доступны аналитика и экспорт отчёта в PDF.

Строка подключения находится в `YusupovMiracle/App.config`. Если SQL Server работает на другом экземпляре, укажите его имя в `data source`.
