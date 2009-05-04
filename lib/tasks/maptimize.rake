namespace :maptimize do
  desc "Sync maptimize server with local data"
  task :sync => :environment do
    if (MAPTIMIZE_AUTHENTICITY_TOKEN == "AUTHENTICITY_TOKEN" || MAPTIMIZE_MAP_KEY =~ /_KEY$/) 
      puts "You must set your authenticity token and maptimize key in config/initializers/maptimize_config.rb"
    else
      system("cd #{Rails.root}; mkdir -p tmp;curl #{MAPTIMIZE_CSV_URL} > tmp/maptimize.csv")
      cmd = ['curl',
             "-u #{MAPTIMIZE_AUTHENTICITY_TOKEN}:X",
             "-X PUT http://www.maptimize.com/api/v1/#{MAPTIMIZE_MAP_KEY}/import",
             '-T tmp/maptimize.csv',
             '-H "Content-Type: text/csv"'].join(' ')
      system cmd
    end
  end
end
