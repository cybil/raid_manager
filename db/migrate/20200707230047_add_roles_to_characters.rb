class AddRolesToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :roles, :text ## will be serialized as an array
  end
end
