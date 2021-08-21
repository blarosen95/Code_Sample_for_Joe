class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :property_name
      t.string :property_address
      t.integer :tenants_max
      t.integer :tenants_present
      t.boolean :listed
      t.boolean :restriction_pets
      t.boolean :restriction_couples

      t.timestamps
    end
  end
end
