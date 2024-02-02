class Api::CommentsController < ApplicationController
  before_action :set_user_and_post, only: [:index, :create]

  def index
    comments = @post.comments
    render json: { user_id: @user.id, post_id: @post.id, comments: comments }
  end

#create
  def create
  comment = @post.comments.create(comment_params.merge(user: @user))
  render json: comment, status: :created
end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
