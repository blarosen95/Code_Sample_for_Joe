class ChangePatientsToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_table :patients, :rooms
  end
end
