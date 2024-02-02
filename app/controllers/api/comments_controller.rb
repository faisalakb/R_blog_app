class Api::CommentsController < ApplicationController
  before_action :set_user_and_post, only: [:index, :create]

  def index
    comments = @post.comments
    render json: { user_id: @user.id, post_id: @post.id, comments: comments }
  end

#create

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
