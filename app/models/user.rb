class User < ApplicationRecord
    # validation
    validates :name, presence: true

    has_many :recipe_groups
end