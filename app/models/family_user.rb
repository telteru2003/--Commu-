class FamilyUser < ApplicationRecord
  belongs_to :user
  belongs_to :family
  # enum status: [:pending, :approved, :rejected]
end
