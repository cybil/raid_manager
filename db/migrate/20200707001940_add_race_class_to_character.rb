class AddRaceClassToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :race, :string
    add_column :characters, :ch_class, :string
  end
end
