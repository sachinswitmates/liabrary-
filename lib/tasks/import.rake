require 'csv'
desc "Import a cities"
task :import_cities => :environment do
    CSV.foreach(Rails.root.join('db/cities.csv'), :headers => true) do |row|
      city = City.find_or_initialize_by(name: row[0].strip)
      city.save if city.new_record?
    end
end