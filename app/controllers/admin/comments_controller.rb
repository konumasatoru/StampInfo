class Admin::CommentsController < ApplicationController

  def destroy
     post = Post.find(params[:post_id])
     Comment.find(params[:id]).destroy
     redirect_to  admin_post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
