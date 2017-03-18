class CreateDogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dogs do |t|
      t.string :name, null: false
      t.integer :gender_cd, null: false
      t.references :breeds, null: false
      t.integer :castrate_cd, null: false
      t.date :birth_date, null: false
      t.string :owner_name, null: false
      t.string :owner_phone, null: false
      t.date :last_visit, null: false
    end
  end
end
