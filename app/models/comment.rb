class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  validates :author, presence: true, length: { minimum: 3, maximum: 20 }
  validates :message, presence: true, length: { minimum: 3 }
  
  self.per_page = 5
  
end
