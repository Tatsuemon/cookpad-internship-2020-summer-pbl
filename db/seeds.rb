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
    Ingredient.create(name: "じゃがいも ##{i}")
end

# MARK: recipe
(1..100).each do |i|
    recipe = Recipe.create(title: "熱々!!!　超絶美味しいカレー ##{i}", description: "このカレーは...##{i}", step: "Recipe ##{i} has many steps", image_url: "nannn.png")
    RecipeTag.create(recipe: recipe, tag_id: i%4+1)

    ingredients = Ingredient.find((1..30).to_a.sample(4))
    (1..4).each do |j|
        RecipeIngredient.create(recipe: recipe, ingredient: ingredients[j], amount: 2.5, unit: "個")
    end
end

# MARK: user
user = User.create(name: "Tatsuemon")