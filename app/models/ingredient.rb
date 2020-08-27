class Ingredient < ApplicationRecord
    # TODO(Tatsuemon): 厳重なvalidation
    # validation
    validates :name, presence: true

    has_many :recipe_ingredients, dependent: :destroy
    has_many :recipes, through: :recipe_ingredients

    has_many :group_ingredients, dependent: :destroy
    has_many :recipe_groups, through: :group_ingredients
end