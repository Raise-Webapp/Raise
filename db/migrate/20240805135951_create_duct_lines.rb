class CreateDuctLines < ActiveRecord::Migration[7.1]
  def change
    create_table :duct_lines do |t|
      t.string :name

      t.timestamps
    end
  end
end
