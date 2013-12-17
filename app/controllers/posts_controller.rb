class PostsController < ApplicationController
  
  # GET: /posts/new
  def new
    @post = Post.new
  end
  
  # POST: /posts
  def create
    # render text: params[:post].inspect # uncomment to debug data
    @post = Post.new(params[:post].permit(:title, :text)) # instanciate new post
    if @post.save                        # save post in database
      redirect_to @post                  # redirect user to the created post
    else
      render "new"                       # errors => stay in new view (and show errors)
    end
  end
  
  # GET: /post/:id
  def show
    @post = Post.find(params[:id])
  end
  
  # GET: /posts
  def index
    @posts = Post.all
  end
  
  # GET: /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render "edit"
    end
  end
  
  # DELETE: /posts/:id
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to posts_path
  end
end
