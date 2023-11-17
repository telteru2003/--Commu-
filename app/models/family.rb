class Family < ApplicationRecord
  has_many :family_users, dependent: :destroy
  has_many :users
  has_many :places, dependent: :destroy
  # has_many :invites, dependent: :destroy
  validates :name, presence: true
end
