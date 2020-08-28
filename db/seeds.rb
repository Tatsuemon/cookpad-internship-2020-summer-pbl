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
ingredient_data = ["じゃがいも", "にんじん", "キャベツ", "牛肉", "鶏肉", "豚肉", "さんま", "玉ねぎ", "長ネギ", "ナッツ", "オレンジ", "グレープフルーツ", "パン", "ご飯", "卵"]
ingredient_data.each do |i|
    Ingredient.create(name: "#{i}")
end

# MARK: recipe
(1..100).each do |i|
    recipe = Recipe.create(title: "熱々!!!　超絶美味しいカレー ##{i}", description: "このカレーは...##{i}", step: "1. じゃがいもとにんじんをぶつ切りにして...##{i}", image_url: "nannn.png")
    RecipeTag.create(recipe: recipe, tag_id: i%4+1)

    ingredients = Ingredient.find((1..ingredient_data.size()).to_a.sample(4))
    (1..4).each do |j|
        RecipeIngredient.create(recipe: recipe, ingredient: ingredients[j], amount: 2.5, unit: "個")
    end
end

# MARK: user
user = User.create(name: "Tatsuemon")