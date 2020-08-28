class RecipeGroup < ApplicationRecord
    belongs_to :user
    belongs_to :saturday_recipe, class_name: "Recipe", foreign_key: "saturday_recipe_id"
    belongs_to :sunday_recipe, class_name: "Recipe", foreign_key: "sunday_recipe_id"
    belongs_to :monday_recipe, class_name: "Recipe", foreign_key: "monday_recipe_id"
    belongs_to :tuesday_recipe, class_name: "Recipe", foreign_key: "tuesday_recipe_id"
    belongs_to :wednesday_recipe, class_name: "Recipe", foreign_key: "wednesday_recipe_id"
    belongs_to :thursday_recipe, class_name: "Recipe", foreign_key: "thursday_recipe_id"
    belongs_to :friday_recipe, class_name: "Recipe", foreign_key: "friday_recipe_id"

    has_many :group_ingredients, dependent: :destroy
    has_many :ingredients, through: :group_ingredients

    def get_recipes
        [
            self.saturday_recipe,
            self.sunday_recipe,
            self.monday_recipe,
            self.tuesday_recipe,
            self.wednesday_recipe,
            self.thursday_recipe,
            self.friday_recipe,
        ]
    end

    def get_cook
        [
            self.saturday_cook,
            self.sunday_cook,
            self.monday_cook,
            self.tuesday_cook,
            self.wednesday_cook,
            self.thursday_cook,
            self.friday_cook,
        ]
    end

    def get_cook_label
        [
            "saturday_cook",
            "sunday_cook",
            "monday_cook",
            "tuesday_cook",
            "wednesday_cook",
            "thursday_cook",
            "friday_cook",
        ]
    end

    def get_cook_params(index, value)
        labels = self.get_cook_label()

        {
            "#{labels[index]}" => value,
            is_changed: true
        }
    end

    def get_cook_recipes
        cook = self.get_cook
        recipes = self.get_recipes

        recipes.select.with_index { |recipe, index| cook[index] }
    end

    # MARK: 複合キーじゃなくなったからこれをする必要なし
    def self.update_recipes(recipe_ids, user_id, start_date)
        sql = <<-SQL
            update `recipe_groups`
            set `saturday_recipe_id` = :saturday_recipe_id,
            `sunday_recipe_id` = :sunday_recipe_id,
            `monday_recipe_id` = :monday_recipe_id,
            `tuesday_recipe_id` = :tuesday_recipe_id,
            `wednesday_recipe_id` = :wednesday_recipe_id,
            `thursday_recipe_id` = :thursday_recipe_id,
            `friday_recipe_id` = :friday_recipe_id,
            `saturday_cook` = true,
            `sunday_cook` = true,
            `monday_cook` = true,
            `tuesday_cook` = true,
            `wednesday_cook` = true,
            `thursday_cook` = true,
            `friday_cook` = true,
            `is_changed` = true
            where `user_id` = :user_id
            and `start_date` = :start_date
        SQL

        ActiveRecord::Base.connection.execute(ActiveRecord::Base.send(
            :sanitize_sql_array,
            [
                sql,
                saturday_recipe_id: recipe_ids[0],
                sunday_recipe_id: recipe_ids[1],
                monday_recipe_id: recipe_ids[2],
                tuesday_recipe_id: recipe_ids[3],
                wednesday_recipe_id: recipe_ids[4],
                thursday_recipe_id: recipe_ids[5],
                friday_recipe_id: recipe_ids[6],
                user_id: user_id,
                start_date: start_date
            ]
        ))

        self.find_by(user_id: user_id, start_date: start_date)
    end
end