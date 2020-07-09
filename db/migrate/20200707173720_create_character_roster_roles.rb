class CreateCharacterRosterRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :character_roster_roles do |t|
      t.string :role
      t.references :character, foreign_key: true
      t.references :roster, foreign_key: true

      t.timestamps
    end
  end
end
