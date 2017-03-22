# == Schema Information
#
# Table name: breeds
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Breed < ActiveRecord::Base
  has_many :dogs


  def self.to_select_component
    Breed.all.map { |breed| { value: breed.id, label: breed.name } }
  end
end
