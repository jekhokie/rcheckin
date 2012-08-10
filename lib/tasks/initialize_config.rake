namespace :db do
  desc 'Copy the database.yml file from database.yml.example'
  task :initialize_config do
    FileUtils.cp 'config/database.yml.example', 'config/database.yml'
  end
end
