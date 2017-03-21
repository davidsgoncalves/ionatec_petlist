require "rails_helper"

RSpec.describe Dog, type: :model do
  let!(:belgian_shepherd) { Breed.create! name: 'Belgian Shepherd'}

  context 'valid attributes' do
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

  context '#search_with_params' do
    let!(:german_shepherd) { Breed.create! name: 'German Shepherd'}

    let!(:german_dog) do
      Dog.create!(
          name: 'German Dog',
          gender_cd: 1,
          breed: german_shepherd,
          castrated: true,
          birth_date: 7.years.ago.to_date,
          owner_name: 'German Guy',
          owner_phone: '555-555',
          last_visit: Date.yesterday
      )
    end

    let!(:belgian_dog) do
      Dog.create!(
          name: 'Belgian Dog',
          gender_cd: 2,
          breed: belgian_shepherd,
          castrated: false,
          birth_date: 5.years.ago.to_date,
          owner_name: 'Belgian Guy',
          owner_phone: '555-555',
          last_visit: 3.days.ago.to_date
      )
    end

    context 'With castrated param' do
      it 'should return German Dog when castrated param is true' do
        expect(Dog.search_with_params({castrated: true})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when castrated param is false' do
        expect(Dog.search_with_params({castrated: false})&.first).to eq belgian_dog
      end
    end

    context 'With name param' do
      it 'should return German Dog when name param filled with "German Dog"' do
        expect(Dog.search_with_params({name: 'German Dog'})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when name param filled with "Belgian Dog"' do
        expect(Dog.search_with_params({name: 'Belgian Dog'})&.first).to eq belgian_dog
      end

      it 'should return 2 dogs when name param filled with "Dog"' do
        expect(Dog.search_with_params({name: 'Dog'})).to include belgian_dog, german_dog
      end

      it 'should not return any dog when name param filled with "Cat"' do
        expect(Dog.search_with_params({name: 'Cat'}).count).to eq 0
      end

      it 'should return 2 dogs when name param is empty' do
        expect(Dog.search_with_params({name: ''})).to include belgian_dog, german_dog
      end
    end

    context 'With gender param' do
      it 'should return German Dog when gender param is 1' do
        expect(Dog.search_with_params({gender_cd: 1})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when gender param is 2' do
        expect(Dog.search_with_params({gender_cd: 2})&.first).to eq belgian_dog
      end
    end

    context 'With breed param' do
      it 'should return German Dog when breed_id param is the id from German Shepherd' do
        expect(Dog.search_with_params({breed_id: german_shepherd.id})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when breed_id param is the id from Belgian Shepherd' do
        expect(Dog.search_with_params({breed_id: belgian_shepherd.id})&.first).to eq belgian_dog
      end
    end

    context 'With owner_name param' do
      it 'should return German Dog when owner name param filled with "German Guy"' do
        expect(Dog.search_with_params({owner_name: 'German Guy'})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when owner name param filled with "Belgian Guy"' do
        expect(Dog.search_with_params({owner_name: 'Belgian Guy'})&.first).to eq belgian_dog
      end

      it 'should return 2 dogs when owner name param filled with "Guy"' do
        expect(Dog.search_with_params({owner_name: 'Guy'})).to include belgian_dog, german_dog
      end

      it 'should not return any dog with owner name param filled with "Not an Owner"' do
        expect(Dog.search_with_params({owner_name: 'Not an Owner'}).count).to eq 0
      end

      it 'should return 2 dogs when owner name param is empty' do
        expect(Dog.search_with_params({owner_name: ''})).to include belgian_dog, german_dog
      end
    end

    context 'With birth_date param' do
      it 'should return German Dog when birth date param is filled with German Dog  birth date' do
        expect(Dog.search_with_params({birth_date: 7.years.ago.to_date})&.first).to eq german_dog
      end

      it 'should return Belgian Dog when birth date param is filled with Belgian Dog birth date' do
        expect(Dog.search_with_params({birth_date: 5.years.ago.to_date})&.first).to eq belgian_dog
      end

      it 'should not return any dog when birth date param is a not birth date of any dog' do
        expect(Dog.search_with_params({birth_date: Date.today}).count).to eq 0
      end
    end

    context 'With last_visit param' do
      it 'should return German Dog when last visit param is filled with a range of date that take German Dog last visit' do
        params = {last_visit_since: 2.days.ago.to_date, last_visit_until: Date.yesterday}
        expect(Dog.search_with_params(params).first).to eq german_dog
      end

      it 'should return Belgian Dog when last visit param is filled with a range of date that take Belgian Dog last visit' do
        params = {last_visit_since: 3.days.ago.to_date, last_visit_until: 2.days.ago.to_date}
        expect(Dog.search_with_params(params).first).to eq belgian_dog
      end

      it 'should return 2 dogs when last visit param is filled with a valid start date' do
        expect(Dog.search_with_params({last_visit_since: 3.days.ago.to_date}).count).to eq 2
      end

      it 'should return 2 dogs when last visit param is filled with a valid end date' do
        expect(Dog.search_with_params({last_visit_until: Date.today}).count).to eq 2
      end
    end
  end
end