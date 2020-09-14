require 'json'
require 'sqlite3'

namespace :sqlite3 do
  task :create do
    whiskey = JSON.parse(File.read(WHISKEY_JSON))
    db = SQLite3::Database.new ENV['SQLITE3_DB']

    db.execute <<-SQL
      create table numbers (
        name varchar(30),
        val int
      );
    SQL

    puts 'Done.'
  end
end
