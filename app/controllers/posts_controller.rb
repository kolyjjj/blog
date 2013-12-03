class PostsController < ApplicationController
  http_basic_authenticate_with name: 'user', password: 'user', except: [:index, :show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
    logger.info "the parameters passed to record: #{params[:post].permit(:title, :text).inspect}"
    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    elsif
      render 'new'
    end
    #render text: params[:post].inspect
  end

  def show
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
