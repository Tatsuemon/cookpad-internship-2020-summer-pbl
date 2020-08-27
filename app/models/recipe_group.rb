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

    def get_recipe_ids
        [
            self.saturday_recipe_id,
            self.sunday_recipe_id,
            self.monday_recipe_id,
            self.tuesday_recipe_id,
            self.wednesday_recipe_id,
            self.thursday_recipe_id,
            self.friday_recipe_id,
        ]
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
            `friday_recipe_id` = :friday_recipe_id
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