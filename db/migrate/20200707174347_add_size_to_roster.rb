class AddSizeToRoster < ActiveRecord::Migration[5.2]
  def change
    add_column :rosters, :size, :integer
  end
end
