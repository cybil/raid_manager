class CreateBasicCompos < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_compos do |t|
      t.string :name

      t.timestamps
    end
    add_column :basic_compos, :template, :jsonb, null: false, default: {}
  end
end
