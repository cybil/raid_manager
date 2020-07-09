class ChangeCharacterRosterRoles < ActiveRecord::Migration[5.2]
  def change
    remove_column :character_roster_roles, :role
    add_column :character_roster_roles, :slot_id, :integer
  end
end
