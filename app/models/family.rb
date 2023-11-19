class Family < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :family_users, dependent: :destroy
  has_many :memberships,  dependent: :destroy
  has_many :users, through: :family_users
  has_many :places, dependent: :destroy
  accepts_nested_attributes_for :places, allow_destroy: true
  # has_many :invites, dependent: :destroy
  validates :name, presence: true

# ユーザがコミュニティに所属していればtrueを返す
    def user_membership?(user)
        users.include?(user)
    end

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
