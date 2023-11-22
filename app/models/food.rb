class Food < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true
  belongs_to :place, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true

  enum consume_status: { 未消費: 0, 消費済み: 1,購入予定: 2 }
  enum genre: { 食料: 0, 飲料: 1, 調味料: 2, その他: 3 }

  def likes_count
    likes.count
  end

  def self.search_for(content,method)
    return none if content.blank?
     if method == 'perfect'
      Food.where(name: content)
    # elsif method == 'forward'
    #   Family.where('name LIKE ?', content + '%')
    # elsif method == 'backword'
    #   Family.where('name LIKE ?', '%' + content)
     else
       Food.where('name LIKE ?', '%' + content + '%')
     end
  end

  def get_foods_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end

end
