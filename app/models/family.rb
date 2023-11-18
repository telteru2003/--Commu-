class Family < ApplicationRecord
  has_many :family_users, dependent: :destroy
  has_many :memberships,  dependent: :destroy
  has_many :users
  has_many :places, dependent: :destroy
  # has_many :invites, dependent: :destroy
  validates :name, presence: true

  def self.search_for(content,method)
    return none if content.blank?
     if method == 'perfect'
      Family.where(name: content)
    # elsif method == 'forward'
    #   Family.where('name LIKE ?', content + '%')
    # elsif method == 'backword'
    #   Family.where('name LIKE ?', '%' + content)
     else
       Family.where('name LIKE ?', '%' + content + '%')
     end
  end

end
