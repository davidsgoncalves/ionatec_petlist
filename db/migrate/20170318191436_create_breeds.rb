class CreateBreeds < ActiveRecord::Migration[5.0]
  def change
    create_table :breeds do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :name
  end
end
