class IngredientsController < ApplicationController
    before_action :current_user

    include YobiDate

    # 一週間分の買い物をするためのリスト
    def index
        today = Date.today()
        recipe_group = RecipeGroup.includes(:ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today))
        @group_ingredients = recipe_group.group_ingredients
    end

    # チェックボックスの更新
    def check
        today = Date.today()
        ingredient_id = params[:id].to_i()
        checked = params[:checked] == "true"
        recipe_group = RecipeGroup.includes(:group_ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today))
        group_ingredient = recipe_group.group_ingredients.find_by(ingredient_id: ingredient_id)
        group_ingredient.update!(checked: checked)
        render json: { code: 200 }
    end
    private
end
