class GroupIngredient < ApplicationRecord
    belongs_to :recipe_group
    belongs_to :ingredient

    validates :checked, inclusion: {in: [true, false]}
end