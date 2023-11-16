class Genre < ApplicationRecord
  has_many :foods, dependent: :destroy
end
