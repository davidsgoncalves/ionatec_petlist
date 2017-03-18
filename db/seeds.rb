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

def check_breed(id)
   Breed.first.id
end

if Dog.count == 0
  puts 'Creating dogs!'
  1000.times do
    Dog.create!(
        name: Faker::Cat.name,
        gender_cd: Faker::Number.between(1, 2),
        breeds_id: Breed.all.map(&:id).sample,
        castrate_cd: Faker::Number.between(0, 1),
        birth_date: Faker::Date.birthday(0, 22),
        owner_name: Faker::Name.name,
        owner_phone: "(#{Faker::Number.number(2)}) 9#{Faker::Number.number(4)}-#{Faker::Number.number(4)}",
        last_visit: Faker::Date.backward(120)
    )
  end
end