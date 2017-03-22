class DogsController < ApplicationController
  def index
    @breeds = Breed.to_select_component
    @dogs = Dog.search_with_params(dog_params.except(:authenticity_token, :utf8, :page))
                .paginate(page: params[:page], per_page: 15)
    @total_entries = @dogs.total_entries
    @dogs = @dogs.map { |dog| dog.as_json.merge(breed: dog.breed.name)}
  end

  private

  def dog_params
    params.permit :name, :gender_cd, :breed_id, :castrated, :birth_date,
                  :owner_name, :owner_name, :last_visit, :page, :authenticity_token,
                  :last_visit_since, :last_visit_until, :utf8
  end
end