require "rails_helper"

RSpec.describe Breed, type: :model do
  context 'valid attributes' do
    it 'should create dog with valid attributes' do
      expect { Breed.create! name: 'Sample name' }.not_to raise_error
    end
  end
end