class User < ApplicationRecord
    # validation
    validates :name, presence: true
end