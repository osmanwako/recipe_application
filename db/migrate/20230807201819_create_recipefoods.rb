class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.integer :quantity, default: 1
      t.references :recipe
      t.references :food

      t.timestamps
    end
  end
end
