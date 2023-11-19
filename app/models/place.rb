class Place < ApplicationRecord
  belongs_to :family
  has_many :foods, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
