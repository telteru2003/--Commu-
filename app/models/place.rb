class Place < ApplicationRecord
  belongs_to :family
  has_many :foods, dependent: :destroy
end
