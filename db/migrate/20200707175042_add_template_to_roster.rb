class AddTemplateToRoster < ActiveRecord::Migration[5.2]
  def change
    add_column :rosters, :template, :jsonb, null: false, default: {}
  end
end
