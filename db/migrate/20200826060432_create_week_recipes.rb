class CreateWeekRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :week_recipes, primary_key: ["user_id", "start_date"] do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date, null: false
      t.bigint :saturday_recipe_id, null: false
      t.bigint :sunday_recipe_id, null: false
      t.bigint :monday_recipe_id, null: false
      t.bigint :tuesday_recipe_id, null: false
      t.bigint :wednesday_recipe_id, null: false
      t.bigint :thursday_recipe_id, null: false
      t.bigint :friday_recipe_id, null: false

      t.timestamps
    end
    add_foreign_key :week_recipes, :recipes, column: :saturday_recipe_id, name: :saturday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :sunday_recipe_id, name: :sunday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :monday_recipe_id, name: :monday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :tuesday_recipe_id, name: :tuesday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :wednesday_recipe_id, name: :wednesday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :thursday_recipe_id, name: :thursday_recipe_id
    add_foreign_key :week_recipes, :recipes, column: :friday_recipe_id, name: :friday_recipe_id
  end
end
