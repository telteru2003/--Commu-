class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20) # remember_tokenを生成して代入
    self.save
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

end
