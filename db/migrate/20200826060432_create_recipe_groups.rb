class CreateRecipeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_groups do |t|
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
    add_foreign_key :recipe_groups, :recipes, column: :saturday_recipe_id, name: :saturday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :sunday_recipe_id, name: :sunday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :monday_recipe_id, name: :monday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :tuesday_recipe_id, name: :tuesday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :wednesday_recipe_id, name: :wednesday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :thursday_recipe_id, name: :thursday_recipe_id
    add_foreign_key :recipe_groups, :recipes, column: :friday_recipe_id, name: :friday_recipe_id

    add_index :recipe_groups, [:user_id, :start_date], unique: true
  end
end
