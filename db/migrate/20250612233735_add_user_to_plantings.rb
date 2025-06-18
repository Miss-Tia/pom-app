class AddUserToPlantings < ActiveRecord::Migration[8.0]
  def change
    add_reference :plantings, :user, null: false, foreign_key: true
  end
end
