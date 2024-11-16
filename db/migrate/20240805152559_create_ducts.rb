class CreateDucts < ActiveRecord::Migration[7.1]
  def change
    create_table :ducts do |t|
      t.integer :width
      t.integer :height
      t.integer :length
      t.string :line_type
      t.string :location
      t.string :floors
      t.string :position
      t.references :duct_line, null: false, foreign_key: true

      t.timestamps
    end
  end
end
