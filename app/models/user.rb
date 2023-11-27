class User < ApplicationRecord
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :family,     optional: true
  has_many :family_users, dependent: :destroy
  has_many :memberships,  dependent: :destroy
  has_many :foods,        dependent: :destroy
  has_many :comments,     dependent: :destroy
  has_many :likes,        dependent: :destroy

  def liked?(food)
    likes.exists?(food: food)
  end

# ゲストログイン
  def self.guest_login
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'ゲストユーザー'
      user.is_active = true
      user.nickname = 'ゲスト'
      user.password = Devise.friendly_token
      user.remember_token = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
    end
  end

# 退会処理を行うメソッド
  def destroy!
    update(is_active: false)
  end

  def get_profile_image
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [100, 100]).processed
    else
      default_image_path = Rails.root.join('app/assets/images/default-image.jpg')
      default_image = File.open(default_image_path)
      profile_image.attach(io: default_image, filename: 'default-image.jpg', content_type: 'image/jpeg')
      default_image.close
      profile_image.variant(resize_to_limit: [100, 100]).processed
    end
  end

  def self.search_for(content,method)
    return none if content.blank?
      if method == 'forward'
        User.where('name LIKE ?', content + '%')
      elsif method == 'backword'
        User.where('name LIKE ?', '%' + content)
      else
        User.where('name LIKE ?', '%' + content + '%')
      end
  end

  def active_for_authentication?
    super && (self.is_active == true)
  end

end
