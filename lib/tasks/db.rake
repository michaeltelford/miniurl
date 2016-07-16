namespace :db do
  desc "Drops all tables from the database but leaves the database itself intact"
  task :drop_tables => :environment do
    conn = ActiveRecord::Base.connection
    conn.tables.select { |t|
      t.start_with? ActiveRecord::Base.table_name_prefix 
    }.each do |t|
      conn.drop_table t
    end
  end
end
