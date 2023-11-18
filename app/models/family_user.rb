class FamilyUser < ApplicationRecord
  belongs_to :user
  belongs_to :family
  validates :user_id, presence: true
  validates :family_id, presence: true
  validates :user_id, uniqueness: { scope: :family_id }
  validates :family_id, uniqueness: { scope: :user_id }
  # enum status: [:pending, :approved, :rejected]
end
