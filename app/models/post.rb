class Post < ActiveRecord::Base
  
  validates :title, presence: true, length: { minimum: 3 }
  
  def self.search(search)
    if search
      search_length = search.split.length
      find(:all, :conditions => [(['title LIKE ?'] * search_length).join(' AND ')] + search.split.map { |title| "%#{title}%" })
    else
      find(:all)
    end
  end
  
end
