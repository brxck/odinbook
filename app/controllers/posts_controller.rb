class PostsController < ApplicationController
  before_action :set_post, except: %i[create index]
  before_action :is_post_owner?, except: %i[create index] 

  def create
    @post = @current_user.posts.new(post_params)

    flash[:danger] = @post.errors.full_messages.to_sentence unless @post.save

    redirect_to :home
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      flash.now[:danger] = @post.errors.full_messages.to_sentence
      render :edit
    end
    
  end

  def index
  end

  def show
    @user = @post.user
    @profile = @user.profile
    @comment = @post.comments.new
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :link)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def is_post_owner?
    unless @post.user == current_user
      flash[:danger] = "You cannot modify this post."
      redirect_back fallback_location: root_path
    end
  end
end
