# == Schema Information
#
# Table name: dogs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  gender_cd   :integer          not null
#  breed_id    :integer          not null
#  castrated   :boolean          not null
#  birth_date  :date             not null
#  owner_name  :string           not null
#  owner_phone :string           not null
#  last_visit  :date             not null
#

class Dog < ActiveRecord::Base
  belongs_to :breed

  as_enum :gender, female: 1, male: 2
end
