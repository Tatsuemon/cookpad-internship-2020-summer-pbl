class Recipe < ApplicationRecord
    # TODO(Tatsuemon): 厳重なvalidation
    # validation
    validates :title, presence: true
    validates :description, presence: true
    validates :step, presence: true

    has_many :recipe_tags, dependent: :destroy
    has_many :tags, through: :recipe_tags

    has_many :recipe_ingredients, dependent: :destroy
    has_many :ingredients, through: :recipe_ingredients

    # TODO(Tatsuemon): has_manyの記述
    # has_many :recipe_groups, 

    # belongs_to :saturday_recipe, class_name: "Recipe", foreign_key: "saturday_recipe_id"
    # belongs_to :sunday_recipe, class_name: "Recipe", foreign_key: "sunday_recipe_id"
    # belongs_to :monday_recipe, class_name: "Recipe", foreign_key: "monday_recipe_id"
    # belongs_to :tuesday_recipe, class_name: "Recipe", foreign_key: "tuesday_recipe_id"
    # belongs_to :wednesday_recipe, class_name: "Recipe", foreign_key: "wednesday_recipe_id"
    # belongs_to :thursday_recipe, class_name: "Recipe", foreign_key: "thursday_recipe_id"
    # belongs_to :friday_recipe, class_name: "Recipe", foreign_key: "friday_recipe_id"
end