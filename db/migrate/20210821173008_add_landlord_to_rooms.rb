class AddLandlordToRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :landlord, null: false, foreign_key: true
  end
end
