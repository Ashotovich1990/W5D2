class PostsController < ApplicationController
  before_action :require_login

  def new 
    @subjects = Sub.all
    :new
  end
  
  def create 
    @post = Post.new(post_params)
    @post.user_id = current_user.id 
    
    if @post.save
      redirect_to post_url(@post)
    else  
      flash.now[:errors] = @post.errors.full_messages 
      render :new 
    end
  end

  def show 
    @post = Post.find_by(id: params[:id])
  end

  def edit 
    @post = Post.find_by(id: params[:id])
  end

  def update 
    @post = Post.find_by(id: params[:id])

    if @post.user_id = current_user.id 
      if @post.update(post_params)
        redirect_to post_url(@post)
      else 
        flash.now[:errors] = @post.errors.full_messages 
        render :edit 
      end
    else 
      render json: "Not your post to edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id]) 
    if @post.user_id == current_user.id 
      @post.destroy 
      flash[:errors] = @post.errors.full_messages
      redirect_to subs_url
    else 
      render json: "Not your post to delete" 
    end
  end


  private 

   def post_params 
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
   end
end
