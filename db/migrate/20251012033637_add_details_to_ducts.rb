class AddDetailsToDucts < ActiveRecord::Migration[7.1]
  def change
    add_column :ducts, :material_type, :string
    add_column :ducts, :material_thickness, :string
    add_column :ducts, :item_number, :integer
  end
end
