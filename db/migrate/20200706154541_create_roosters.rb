class CreateRoosters < ActiveRecord::Migration[5.2]
  def change
    create_table :roosters do |t|
      t.string :name

      t.timestamps
    end
  end
end
