class PostsController < ApplicationController
  
  before_filter :get_post, :only => [:show, :edit, :destroy, :update]
  
  http_basic_authenticate_with name: "blog", password: "blog", except: [:index, :show]
  
  # GET: /posts/new
  def new
    @post = Post.new
  end
  
  # POST: /posts
  def create
    # render text: params[:post].inspect # uncomment to debug data
    @post = Post.new(get_params) # instanciate new post
    if @post.save                        # save post in database
      redirect_to @post                  # redirect user to the created post
    else
      render "new"                       # errors => stay in new view (and show errors)
    end
  end
  
  # GET: /post/:id
  def show
    @comments = @post.comments.paginate(page: params[:page])
  end
  
  # GET: /posts
  def index
    @posts = Post.where(draft: [false, nil]).order(updated_at: :desc).paginate(page: params[:page])
    @title = 'Listing posts (' + @posts.count.to_s + ')'
  end
  
  # GET: /posts/:id/edit
  def edit
    # nothing
  end
  
  def update    
    if @post.update(get_params)
      redirect_to @post
    else
      render "edit"
    end
  end
  
  # DELETE: /posts/:id
  def destroy
    @post.destroy    
    redirect_to posts_path
  end
  
  # GET: /search/:q
  def search
    @posts = Post.paginate(page: params[:page]).search(params[:q])
    @title = "Results for '" + params[:q] + "' (" + @posts.count.to_s + ')'
    render 'index'
  end
  
  # GET: /drafts
  def drafts
    @posts = Post.drafts.paginate(page: params[:page])
    @title = 'Listing drafts (' + @posts.count.to_s + ')'
    render 'index'
  end
  
  private
  
  def get_post
    @post = Post.find(params[:id])
  end
  
  def get_params
    params[:post].permit(:title, :text, :draft)
  end
end
