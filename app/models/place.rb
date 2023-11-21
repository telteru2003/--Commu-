class Place < ApplicationRecord
  belongs_to :family
  has_many :foods

  validates :name, uniqueness: true, presence: true
end
