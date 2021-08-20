class ChangeUsersToPatients < ActiveRecord::Migration[6.1]
  def change
    rename_table :patients, :patients
  end
end
