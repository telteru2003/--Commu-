class User < ApplicationRecord
  has_one_attached :profile_image
  # before_create :generate_remember_token

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :family
  has_many :foods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # validates :email, presence: true

  # def generate_and_save_remember_token
  #   self.generate_remember_token
  #   self.save
  # end

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
    unless profile_image.attached?  # 修正
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  # protected

  # def generate_remember_token
  #   self.remember_token = SecureRandom.urlsafe_base64
  # end

  def active_for_authentication?
    super && (self.is_active == true)
  end

end
