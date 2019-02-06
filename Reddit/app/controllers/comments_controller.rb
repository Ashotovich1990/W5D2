class CommentsController < ApplicationController

  def show 
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    comment = Comment.new(comment_params) 
    comment.user_id = current_user.id
    post = Post.find_by(id: params[:comment][:post_id]) 
    comment.post_id = post.id
    comment.save 
    flash.now[:errors] = comment.errors.full_messages 
    redirect_to post_url(post)
  end

  private 
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id) 
  end
end
