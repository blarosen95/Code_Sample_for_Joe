class CreateLandlords < ActiveRecord::Migration[6.1]
  def change
    create_table :landlords do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end
end
