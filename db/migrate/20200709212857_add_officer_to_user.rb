class AddOfficerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :officer, :boolean, default: false, null: false
  end
end
