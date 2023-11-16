class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :invites, dependent: :destroy
end
