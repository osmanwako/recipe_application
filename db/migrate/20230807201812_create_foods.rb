class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit, default: "Kg"
      t.decimal :price, default: 1.0
      t.integer :quantity, default: 1
      t.references :user

      t.timestamps
    end
  end
end
