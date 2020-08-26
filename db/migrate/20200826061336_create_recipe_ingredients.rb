class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients, primary_key: ["recipe_id", "ingredient_id"] do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :amount
      t.string :unit

      t.timestamps
    end
  end
end
