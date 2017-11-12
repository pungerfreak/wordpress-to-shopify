# README

* Converting MySQL database to SQLite3 database
 - https://github.com/dumblob/mysql2sqlite
 - chmod u+x mysql2sqlite.sh
 - mysqldump --skip-extended-insert --compact -u root wordpress > wordpress.sql
 - ./mysql2sqlite.sh wordpress.sql | sqlite3 development.sqlite3
