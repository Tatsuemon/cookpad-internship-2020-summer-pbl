class GachasController < ApplicationController
    before_action :current_user

    include YobiDate

    # ガチャを促す画面
    def index
    end

    # ガチャを行うアクション
    def create
        recipes = Recipe.all().sample(7)
        recipe_ids = recipes.map(&:id)
        today = Date.today()
        week_recipe = WeekRecipe.find_by(user: current_user, start_date: get_saturday(today))
        if week_recipe.present?
            WeekRecipe.update_recipes(recipe_ids, current_user.id, get_saturday(today))
        else
            week_recipe = WeekRecipe.new(user: current_user, start_date: get_saturday(today))
            week_recipe.update!(week_recipe_params(recipes))
        end
        redirect_to "/recipes"
    end

    private

    def week_recipe_params(recipes)
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
