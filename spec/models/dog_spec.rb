require "rails_helper"

RSpec.describe Dog, type: :model do
  context 'valid attributes' do
    let!(:breed) { Breed.create! name: 'Pastor Belga'}

    it 'should create dog with valid attributes' do
      expect {
        Dog.create!(
            name: Faker::Cat.name,
            gender_cd: Faker::Number.between(1, 2),
            breed_id: Breed.all.map(&:id).sample,
            castrated: Faker::Boolean.boolean,
            birth_date: Faker::Date.birthday(0, 22),
            owner_name: Faker::Name.name,
            owner_phone: "(#{Faker::Number.number(2)}) 9#{Faker::Number.number(4)}-#{Faker::Number.number(4)}",
            last_visit: Faker::Date.backward(120)
        )
      }.not_to raise_error
    end
  end
end