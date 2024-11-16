class MoveDuctTypeToDuct < ActiveRecord::Migration[7.1]
  def change
    remove_column :duct_lines, :duct_type
    add_column :ducts, :duct_type, :string, null: true
  end
end
