class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_and_post, only: %i[index create]

  def index
    comments = @post.comments
    render json: { user_id: @user.id, post_id: @post.id, comments: }
  end

  def create
    Rails.logger.info('Create action reached!')

    @comment = @post.comments.build(comment_params.merge(user: @user))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages, action: 'create' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user_and_post
    @user = User.find_by(id: params[:user_id])
    @post = @user&.posts&.find_by(id: params[:post_id])

    return if @user && @post

    render json: { error: 'User or post not found' }, status: :not_found
  end
end
