class AddDuctType < ActiveRecord::Migration[7.1]
  def change
    add_column :duct_lines, :duct_type, :string, null: true
  end
end
