class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name,null: false, default: "Unkown"
      t.string :preparation_time,null: false, default: "1hr"
      t.string :cooking_time,null: false, default: "1hr"
      t.text :description,null: false, default: ""
      t.boolean :public, default:0
      t.references :user

      t.timestamps
    end
  end
end
