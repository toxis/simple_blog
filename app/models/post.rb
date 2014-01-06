class Post < ActiveRecord::Base
  
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 3 }
  
  scope :drafts, -> { where(draft: true).order(updated_at: :desc) }
  
  def self.search(search)
    if search
      search_length = search.split.length
      find(:all, :conditions => [(['title LIKE ?'] * search_length).join(' AND ')] + search.split.map { |title| "%#{title}%" })
    else
      find(:all)
    end
  end
  
end
