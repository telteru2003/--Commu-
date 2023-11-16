class Food < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true
  belongs_to :genre, optional: true
  belongs_to :place, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true

  enum consume_status: { 未消費: 0, 消費済み: 1 }


  def get_foods_image
    unless image.attached?  # 修正
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end

end
