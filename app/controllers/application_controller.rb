class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :count_posts_and_drafts
  
  private
  
  def count_posts_and_drafts
    @number_of_drafts = Post.where(draft: true).count
    @number_of_posts = Post.all.count - @number_of_drafts    
  end
end
