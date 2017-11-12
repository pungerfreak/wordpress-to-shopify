task convert_database: :environment do
  db_name = 'wordpress'
  db_dump_loc = File.join(Rails.root, "db/#{db_name}.sql")
  sqlite3_db = File.join(Rails.root, 'db/development.sqlite3')
  user = 'root'
  pass = nil
  converter = File.join(Rails.root, 'lib/vendor/mysql2sqlite.sh')

  abort("ERROR: mysql2sqlite script cannot be found in ./lib/vendor") unless system "[ -f '#{converter}' ]"
  
  system("chmod u+x '#{converter}'")
  system("mysqldump --skip-extended-insert --compact -u #{user} #{('-p ' + pass) unless pass.blank?} #{db_name} > '#{db_dump_loc}'")
  system("rm '#{sqlite3_db}'") if system "[ -f '#{sqlite3_db}' ]"
  system("'#{converter}' '#{db_dump_loc}' | sqlite3 '#{sqlite3_db}'")
end
