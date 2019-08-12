# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

module Seeder
  def self.seed(file)
    puts "Seeding #{file.titleize}"
    path = File.expand_path(File.join(Rails.root, "db", "seed", "#{file}.rb"))
    require path
  end
end

Seeder.seed("admins")
