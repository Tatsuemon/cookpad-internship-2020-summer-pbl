class RecipesController < ApplicationController
    before_action :authentification_user?

    include YobiDate
    # 一週間の献立を表示
    def index
        today = Date.today
        @recipe_group = RecipeGroup.find_by(user_id: @current_user.id, start_date: get_saturday(today))
        return redirect_to "/" if @recipe_group.blank?
        @recipes = @recipe_group.get_recipes()
        @yobis = ["土曜日", "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日"]
    end

    # レシピの詳細
    def show
        @recipe = Recipe.includes(:ingredients).find(params[:id])
    end

    # 1週間のレシピで食べるものの選定
    def check
        today = Date.today()
        yobi_number = params[:id].to_i
        checked = params[:checked] == "true"
        recipe_group = RecipeGroup.find_by(user_id: @current_user.id, start_date: get_saturday(today))
        params = recipe_group.get_cook_params(yobi_number, checked)
        # updateはsaveを読んでるため, recipesを読みこんでいる
        recipe_group.update!(params)
        render json: { code: 200 }
    end

    private
end
