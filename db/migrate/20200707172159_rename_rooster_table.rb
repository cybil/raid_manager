class RenameRoosterTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :roosters, :rosters
  end
end
