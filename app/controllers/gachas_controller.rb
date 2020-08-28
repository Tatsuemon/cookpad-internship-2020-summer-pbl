require "set"
class GachasController < ApplicationController
    before_action :authentification_user?

    include YobiDate

    # ガチャを促す画面
    def index
    end

    # ガチャを行うアクション
    def create
        # TODO(Tatsuemon): localhostでしか起動しないということを考えてのこれ
        sleep(4)
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
            redirect_to "/recipes"
        rescue => error
            p error
            redirect_to "/"
        end
    end

    private

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
