class ChangeCastrateToBool < ActiveRecord::Migration[5.0]
  def change
    rename_column :dogs, :castrate_cd, :castrated
    change_column :dogs, :castrated, :boolean
  end
end
