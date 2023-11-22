class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :food

  def self.search_for(content,method)
    return none if content.blank?
      if method == 'forward'
        Comment.where('body LIKE ?', content + '%')
      elsif method == 'backword'
        Comment.where('body LIKE ?', '%' + content)
      else
        Comment.where('body LIKE ?', '%' + content + '%')
      end
  end

end
