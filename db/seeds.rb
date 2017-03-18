# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Breed.count == 0
  puts 'Creating breeds!'
  File.open('db/breeds.txt', 'r').each_line do |line|
    Breed.create! name: line.strip
  end
end