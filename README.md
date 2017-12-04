# README

* Using MySQL
 - For versions prior to 5.7.4 the `STRICT_TRANS_TABLES` sql_mode needs to be removed from the configuration before migrations will work
* Converting MySQL database to SQLite3 database
 - https://github.com/dumblob/mysql2sqlite
 - chmod u+x mysql2sqlite.sh
 - mysqldump --skip-extended-insert --compact -u root wordpress > wordpress.sql
 - ./mysql2sqlite.sh wordpress.sql | sqlite3 development.sqlite3

# Temporary notes

Post.find(849) is doing some strange stuff, validating horribly and cutting out some characters at the end
height=\"300\"hat’s


some complicated posts
39: strip all formatting except paragraphs?
2515: need to figure out how to handle the tabular data


 <a class="yt-uix-redirect-link" dir="ltr" style="color: #1b7fcc;" title="http://www.fishingaddictsnorthwest.com" href="http://www.fishingaddictsnorthwest.com/" target="_blank" rel="nofollow">http://www.fishingaddictsnorthwest.com</a> <a class="yt-uix-redirect-link" dir="ltr" style="color: #1b7fcc;" title="http://www.lamiglas.com" href="http://www.lamiglas.com/" target="_blank" rel="nofollow">http://www.lamiglas.com</a> <a class="yt-uix-redirect-link" dir="ltr" style="color: #1b7fcc;" title="http://www.gonecatchin.com" href="http://www.gonecatchin.com/" target="_blank" rel="nofollow">http://www.gonecatchin.com</a>