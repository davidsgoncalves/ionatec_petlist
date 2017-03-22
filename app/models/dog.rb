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

  def self.search_with_params(params)
    relation = Dog.all

    relation = relation.where(castrated: params[:castrated]) unless params[:castrated] == nil
    relation = relation.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    relation = relation.where(gender_cd: params[:gender_cd]) if params[:gender_cd].present?
    relation = relation.where(breed_id: params[:breed_id]) if params[:breed_id].present?
    relation = relation.where('owner_name LIKE ?', "%#{params[:owner_name]}%") if params[:owner_name].present?
    relation = relation.where(birth_date: params[:birth_date]) if params[:birth_date].present?

    relation = relation.where('last_visit >= ?', params[:last_visit_since]) if params[:last_visit_since].present?
    relation = relation.where('last_visit <= ?', params[:last_visit_until]) if params[:last_visit_until].present?

    relation
  end
end
