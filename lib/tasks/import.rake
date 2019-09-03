require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do   
    CSV.foreach(Rails.root.join('db/cities.csv'), :headers => true) do |row|
      City.create({
    name: row[0].strip
  })
    end
end