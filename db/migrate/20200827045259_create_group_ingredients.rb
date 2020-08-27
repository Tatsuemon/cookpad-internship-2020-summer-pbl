class CreateGroupIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :group_ingredients do |t|
      t.references :recipe_group, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.boolean :checked, null: false, default: false
      t.decimal :amount, precision: 12, scale: 2
      t.string :unit
    end

    add_index :group_ingredients, [:recipe_group_id, :ingredient_id], unique: true
  end
end
