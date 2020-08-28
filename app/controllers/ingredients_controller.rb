class IngredientsController < ApplicationController
    before_action :authentification_user?

    include YobiDate

    # 一週間分の買い物をするためのリスト
    def index
        today = Date.today()
        recipe_group = RecipeGroup.includes(:ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today))
        return redirect_to "/" if recipe_group.blank?

        if recipe_group.is_changed
            calc_ingredient_amount(recipe_group)
            @group_ingredients = RecipeGroup.includes(:ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today)).group_ingredients
        else
            @group_ingredients = recipe_group.group_ingredients
        end
    rescue => e
        p e
        recirect_to '/'
    end

    # チェックボックスの更新
    def check
        today = Date.today()
        ingredient_id = params[:id].to_i
        checked = params[:checked] == "true"
        recipe_group = RecipeGroup.includes(:group_ingredients).find_by(user_id: @current_user.id, start_date: get_saturday(today))
        group_ingredient = recipe_group.group_ingredients.find_by(ingredient_id: ingredient_id)
        group_ingredient.update!(checked: checked)
        render json: { code: 200 }
    end
    private

    def calc_ingredient_amount(recipe_group)
        ActiveRecord::Base.transaction do
            recipes = recipe_group.get_cook_recipes()
            ingredients = recipes.map(&:ingredients).flatten()
            ingredients = Set.new(ingredients)

            # TODO(Tatsuemon): 改善
            recipe_ingredients = recipes.map(&:recipe_ingredients).flatten

            group_ingredients = GroupIngredient.where(recipe_group: recipe_group)

            group_ingredients.delete_all() if group_ingredients.present?
            ingredients.each do |ingredient|
                # TODO(Tatsuemon): 改善
                selected_recipe_ingredients = recipe_ingredients.select { |recipe_ingredient| recipe_ingredient.ingredient == ingredient}

                amount = selected_recipe_ingredients.sum { |selected_recipe_ingredient| selected_recipe_ingredient[:amount]}
                unit = selected_recipe_ingredients.map(&:unit).compact().first()

                group_ingredient = GroupIngredient.new(recipe_group: recipe_group, ingredient: ingredient, amount: amount, unit: unit, checked: false)
                group_ingredient.save!
            end
            recipe_group.update!(is_changed: false)
        end
    end
end
