class ChangeRoomsToLandlords < ActiveRecord::Migration[6.1]
  def change
    rename_table :rooms, :landlords
  end
end
