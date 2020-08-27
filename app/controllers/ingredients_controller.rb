class IngredientsController < ApplicationController
    before_action :current_user

    include YobiDate

    # 一週間分の買い物をするためのリスト
    def index
        today = Date.today()
        recipe_group = RecipeGroup.includes(:ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today))
        @group_ingredients = recipe_group.group_ingredients
    end

    private
end
