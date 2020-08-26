# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# MARK: tag
tags = ["fish", "meet", "salad", "soup"]
tags.each do |tag|
    Tag.create(name: tag)
end

# MARK: ingredient
(1..30).each do |i|
    Ingredient.create(name: "Ingredient ##{i}")
end

# MARK: recipe
(1..100).each do |i|
    recipe = Recipe.create(title: "Recipe ##{i}", description: "Recipe ##{i} description", step: "Recipe ##{i} has many steps")
    RecipeTag.create(recipe: recipe, tag_id: i%4+1)

    ingredients = Ingredient.find((1..30).to_a.sample(4))
    (1..4).each do |j|
        RecipeIngredient.create(recipe: recipe, ingredient: ingredients[j], amount: 2.5, unit: "個")
    end
end

# MARK: user
user = User.create(name: "Tatsuemon")

recipes = Recipe.find((1..100).to_a.sample(7))

# MARK: week_recipe
WeekRecipe.create(
    user: user,
    start_date: Date.new(2020, 8, 22),
    saturday_recipe_id: recipes[0].id,
    sunday_recipe_id: recipes[1].id,
    monday_recipe_id: recipes[2].id,
    tuesday_recipe_id: recipes[3].id,
    wednesday_recipe_id: recipes[4].id,
    thursday_recipe_id: recipes[5].id,
    friday_recipe_id: recipes[6].id,
)