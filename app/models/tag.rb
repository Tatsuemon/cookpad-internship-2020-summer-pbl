class Tag < ApplicationRecord
    # validation
    validates :name, presence: true

    has_many :recipe_tags, dependent: :destroy
    has_many :recipes, through: :recipe_tags
end