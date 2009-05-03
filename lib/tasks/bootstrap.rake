desc "Fill database with a some data"
task :bootstrap => :environment do 
  Business.delete_all
  File.open(File.join(Rails.root, 'db', 'bootstrap.csv')) do |file|
    file.gets
    while (line = file.gets)
      data = line.split(',')
      business = Business.new(:lat => data[0], :lng => data[1], :name => data[2])
      business.id = data[3]
      business.save
    end
  end
  initializer = File.join(Rails.root, 'config', 'initializers', 'maptimize_config.rb')
  system("ruby -pi.bak -e '$_.gsub!(\"DEVELOPMENT_KEY\", \"025bcbc91bef24e9f545dd3124844c3a97214dda\")' #{initializer}")
end