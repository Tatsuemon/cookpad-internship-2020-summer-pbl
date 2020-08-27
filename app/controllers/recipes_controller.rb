class RecipesController < ApplicationController
    before_action :current_user

    include YobiDate
    # 一週間の献立を表示
    def index
        today = Date.today
        @week_recipe = WeekRecipe.find_by(user_id: current_user.id, start_date: get_saturday(today))
        return redirect_to "/" if @week_recipe.blank?
        
        @recipes = Recipe.where(id: @week_recipe.get_recipe_ids())

        @yobis = ["土曜日", "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日"]
    end

    # レシピの詳細
    def show
        @recipe = Recipe.includes(:ingredients).find(params[:id])
    end

    private
end
