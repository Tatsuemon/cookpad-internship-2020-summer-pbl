require "set"
class GachasController < ApplicationController
    before_action :current_user

    include YobiDate

    # ガチャを促す画面
    def index
    end

    # ガチャを行うアクション
    def create
        ActiveRecord::Base.transaction do
            recipe_counts = Recipe.count()
            recipe_ids = (1..recipe_counts).to_a.sample(7)
            recipes = Recipe.includes(:ingredients).find(recipe_ids)

            today = Date.today()
            @recipe_group = RecipeGroup.find_by(user: @current_user, start_date: get_saturday(today))
            if @recipe_group.present?
                group_ingredients = GroupIngredient.where(recipe_group_id: @recipe_group.id)
                group_ingredients.delete_all() if group_ingredients.present?

                @recipe_group = RecipeGroup.update_recipes(recipe_ids, @current_user.id, get_saturday(today))
            else
                @recipe_group = RecipeGroup.new(user: @current_user, start_date: get_saturday(today))
                @recipe_group.update!(recipe_group_params(recipes))
            end

            ingredients = recipes.map(&:ingredients).flatten()
            ingredients = Set.new(ingredients)

            recipe_ingredients = recipes.map(&:recipe_ingredients).flatten

            ingredients.each do |ingredient|
                selected_recipe_ingredients = recipe_ingredients.select { |recipe_ingredient| recipe_ingredient.ingredient == ingredient}

                amount = selected_recipe_ingredients.sum { |selected_recipe_ingredient| selected_recipe_ingredient[:amount]}
                unit = selected_recipe_ingredients.map(&:unit).compact().first()

                group_ingredient = GroupIngredient.new(recipe_group: @recipe_group, ingredient: ingredient, amount: amount, unit: unit, checked: false)
                group_ingredient.save!
            end
            redirect_to "/recipes"
        rescue => error
            p error
            redirect_to "/"
        end
    end

    private

    def get_ingredient_amount(ingredient, recipe)

    end

    def recipe_group_params(recipes)
        {
            saturday_recipe: recipes[0],
            sunday_recipe: recipes[1],
            monday_recipe: recipes[2],
            tuesday_recipe: recipes[3],
            wednesday_recipe: recipes[4],
            thursday_recipe: recipes[5],
            friday_recipe: recipes[6],
        }
    end
end
